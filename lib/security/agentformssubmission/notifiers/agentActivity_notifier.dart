import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/security/agentformssubmission/models/agentActivity_payload.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

class SaveAgentActivityNotifier extends StateNotifier<IsLoading> {
  SaveAgentActivityNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> saveAgentActivity({required String refId}) async {
    isLoading = true;

    try {
      final payload = AgentActivityPayload(refId: refId);
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.agentrefi)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
