import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:riverpod/riverpod.dart';
import 'package:saferent/security/agentformssubmission/models/agentform_payload.dart';
import 'package:saferent/security/agentformssubmission/typedefs/agentform_id.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

class SubmitAgentFormNotifier extends StateNotifier<IsLoading> {
  SubmitAgentFormNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> submitForm(
      {required String phoneNumber,
      required String names,
      required UserId fromuserId,
      required AgentFormId formId,
      required DateTime createdAt,
      required String location,
      required String email,
      required String ninNumber,
      required String refNo,
      required String educationLevel}) async {
    isLoading = true;
    try {
      final payload = AgentsFormPayLoad(
          email: email,
          phoneNumber: phoneNumber,
          ninNumber: ninNumber,
          educationLevel: educationLevel,
          refNo: refNo,
          createdAt: DateTime.timestamp(),
          names: names,
          location: location,
          userId: fromuserId,
          formId: formId);

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.agentsform)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
