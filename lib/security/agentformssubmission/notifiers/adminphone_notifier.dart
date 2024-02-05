import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:riverpod/riverpod.dart';
import 'package:saferent/admin/models/admin_save_number_payload.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';


class SaveAdminPhoneNotifier extends StateNotifier<IsLoading> {
  SaveAdminPhoneNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> saveVerifiedAdmin({
    required String adminPhone,
  }) async {
    isLoading = true;
    try {
      final payload = AdminPhoneNumberPayLoad(adminPhone: adminPhone);
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.verifyad)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
