import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/rent_colection/model/tenant_payload.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

class SubmitTenantFormNotifier extends StateNotifier<IsLoading> {
  SubmitTenantFormNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> submitTenant(
      {required UserId fromUserId,
      required String phoneNumber,
      required String amount,
      required String ninNumber,
      required String names,
      required String location,
      required String unitnumber,
      required String email,
      required DateTime createdAt,
      required String landlordRef}) async {
    isLoading = true;
    final payload = TenantsPayLoad(
        fromUserId: fromUserId,
        names: 'names',
        phoneNumber: 'phoneNumber',
        location: 'location',
        unitNumber: 'unitNumber',
        ninNumber: 'ninNumber',
        rentAmount: 0,
        email: 'email',
        landLordRef: 'landlordRef');
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.tenantReg)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
