import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/rent_colection/model/landlord_payload.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

class SubmitLandlordNotifier extends StateNotifier<IsLoading> {
  SubmitLandlordNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> submitLandlord(
      {required UserId fromUserId,
      required String phoneNumber,
      required String refId,
      required String location,
      required String bankAccount,
      required String email,
      required String unitNos,
      required String names}) async {
    isLoading = true;
    final payload = LandLordPayload(
        names: names,
        phoneNumber: phoneNumber,
        email: email,
        unitNos: unitNos,
        location: location,
        bankAccount: bankAccount,
        refId: refId,
        fromUserId: fromUserId);
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.landlord)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
