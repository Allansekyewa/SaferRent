import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/feedback/models/feedback_payload.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';
import 'package:saferent/state/posts/typedefs/post_id.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

class SendFeedbackNotifier extends StateNotifier<IsLoading> {
  SendFeedbackNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> sendFeedback({
    required UserId fromUserId,
    required PostId onPostId,
    required String feedback,
  }) async {
    isLoading = true;
    final payload = FeedBackPayload(
      fromUserId: fromUserId,
      onPostId: onPostId,
      feedback: feedback,
    );
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.feedback)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
