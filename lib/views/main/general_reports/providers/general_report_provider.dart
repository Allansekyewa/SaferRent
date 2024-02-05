import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';
import 'package:saferent/views/main/general_reports/notifiers/general_reports_notifier.dart';

final submitReportProvider =
    StateNotifierProvider<SubmitGeneralReportsNotifier, IsLoading>(
        (_) => SubmitGeneralReportsNotifier());
