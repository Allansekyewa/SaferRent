import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/propertySales/notifiers/submitPropertyForm_notifier.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

final propertySalesProvider =
    StateNotifierProvider<SubmitPropertySalesNotifier, IsLoading>(
        (_) => SubmitPropertySalesNotifier());
