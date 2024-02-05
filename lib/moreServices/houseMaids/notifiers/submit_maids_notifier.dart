import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:riverpod/riverpod.dart';
import 'package:saferent/moreServices/houseMaids/maids_payload.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

class SubmitMaidsFormNotifier extends StateNotifier<IsLoading> {
  SubmitMaidsFormNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> submitMaidsForm(
      {required String phoneNumber,
      required String handlerName,
      required String description,
      required String names,
      required String handlersPhone,
      required DateTime createdAt}) async {
    isLoading = true;
    try {
      final payload = HouseMaidPayload(
        names: names,
        phoneNumber: phoneNumber,
        handlerName: handlerName,
        handlersPhone: handlersPhone,
        description: description,
        createdAt: DateTime.timestamp(),
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.houseMai)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
