import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/moreServices/movingServices/models/movers_payload.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

class SubmitMoverFormNotifier extends StateNotifier<IsLoading> {
  SubmitMoverFormNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> submitMovers(
      {required String phoneNumber,
      required String companyName,
      required DateTime createdAt,
      required String location,
      required String names}) async {
    isLoading = true;
    try {
      final payload = MoversPayload(
          companyName: companyName,
          phoneNumber: phoneNumber,
          location: location,
          names: names,
          createdAt: DateTime.timestamp());
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.movers)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
