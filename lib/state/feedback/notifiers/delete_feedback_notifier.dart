import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/feedback/typedefs/feedback_id.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

class DeleteFeedbackStateNotifier extends StateNotifier<IsLoading> {
  DeleteFeedbackStateNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> deleteFeedback({
    required FeedBackId feedbackId,
  }) async {
    try {
      isLoading = true;
      final query = FirebaseFirestore.instance
          .collection(FirebaseCollectionName.feedback)
          .where(FieldPath.documentId, isEqualTo: feedbackId)
          .limit(1)
          .get();
      await query.then((query) async {
        for (final doc in query.docs) {
          await doc.reference.delete();
        }
      });
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
