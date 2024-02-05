import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/propertySales/model/submit_passcode_payload.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

class SubmitPasscodeNotifier extends StateNotifier<IsLoading> {
  SubmitPasscodeNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> submitpasscode(
      {required String passCode, required DateTime createdAt}) async {
    isLoading = true;
    try {
      final payload = SubmitPasscodePayload(passcode: passCode);
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.passco)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
