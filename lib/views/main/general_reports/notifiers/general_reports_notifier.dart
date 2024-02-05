import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';
import 'package:saferent/views/main/general_reports/models/reports_payload.dart';

class SubmitGeneralReportsNotifier extends StateNotifier<IsLoading> {
  SubmitGeneralReportsNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> submitReport(
      {required String report, required DateTime createdAt}) async {
    isLoading = true;
    try {
      final payload =
          ReportsPayload(report: report, createdAt: DateTime.timestamp());
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.reports)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
