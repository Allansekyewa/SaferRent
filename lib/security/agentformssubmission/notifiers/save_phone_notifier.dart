import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/admin/models/phone_number_payload.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

class SavePhoneNotifier extends StateNotifier<IsLoading> {
  SavePhoneNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> saveVerifiedPhoneNumber(
      {required String phoneNumber,
      required String agentId,
      required String refNumber,
      required ninNumber}) async {
    isLoading = true;
    try {
      final payload = PhoneNumberPayLoad(
          phoneNumber: phoneNumber,
          agentId: agentId,
          refPhone: refNumber,
          ninNumber: ninNumber,
          cretaedAt: DateTime.timestamp());
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.verified)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
