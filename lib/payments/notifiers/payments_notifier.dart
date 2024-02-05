import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/payments/model/payment_payLoad.dart';
import 'package:saferent/payments/typedefs/payment_id.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';
import 'package:saferent/state/posts/typedefs/post_id.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

class ProcessPaymentNotifier extends StateNotifier<IsLoading> {
  ProcessPaymentNotifier() : super(false);
  set isLoading(bool value) => state = value;

  Future<String> _fetchAgentPhoneNumber(String userId) async {
    final agentDocumentSnapshot = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.agentsform)
        .doc(userId)
        .get();

    final agentData = agentDocumentSnapshot.data();
    final agentPhoneNumber = agentData?['phoneNumber'];

    if (agentPhoneNumber != null) {
      return agentPhoneNumber.toString();
    } else {
      throw ("Agent phone number not found");
    }
  }

  Future<String> _fetchPostDescription(String postId) async {
    final postDocumentSnapshot = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.posts)
        .doc(postId)
        .get();

    if (postDocumentSnapshot.exists) {
      return postDocumentSnapshot.get('description') as String;
    } else {
      throw ("Post not found");
    }
  }

  Future<String> _fetchClientName(String userId) async {
    final userDocumentSnapshot = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .doc(userId)
        .get();

    final userData = userDocumentSnapshot.data();
    final clientName = userData?['displayName'];

    if (clientName != null) {
      return clientName.toString();
    } else {
      throw ("Client name not found");
    }
  }

  Future<bool> processPayments(
      {required PaymentId id,
      required PostId onPostId,
      required UserId fromUserId,
      required DateTime paidAt,
      required String serviceProvider,
      required String paymentFor,
      required double amount,
      required String reason}) async {
    isLoading = true;
    try {
      final agentPhoneNumber = await _fetchAgentPhoneNumber(fromUserId);
      final postDescription = await _fetchPostDescription(onPostId);
      final clientName = await _fetchClientName(fromUserId);
      const reason1 = 'Property Field Tour Fee';
      double amount = 50000.0;
      const servicepro = '';

      final payload = ProcessPaymentsPayload(
        id: id,
        agentPhoneNumber: agentPhoneNumber,
        serviceProvider: servicepro,
        paymentFor: postDescription,
        onPostId: onPostId,
        amount: amount,
        fromUserId: fromUserId,
        clientsName: clientName,
        reason: reason1,
      );

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.payments)
          .doc(fromUserId)
          .set(payload);

      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
