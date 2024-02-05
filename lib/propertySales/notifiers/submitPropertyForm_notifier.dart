import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/propertySales/model/property_sales_payload.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

class SubmitPropertySalesNotifier extends StateNotifier<IsLoading> {
  SubmitPropertySalesNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> submitPropertySales({
    required String names,
    required String description,
    required String type,
    required String location,
    required DateTime createdAt,
    required String phoneNumber,
  }) async {
    isLoading = true;
    try {
      final payload = PropertySalesPayload(
          location: location,
          phoneNumber: phoneNumber,
          names: names,
          description: description,
          type: type,
          submittedAt: DateTime.timestamp());
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.propertySales)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
