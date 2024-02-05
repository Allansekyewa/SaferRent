import 'package:riverpod/riverpod.dart';
import 'package:saferent/moreServices/houseMaids/notifiers/submit_maids_notifier.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

final submitMaidsProvider =
    StateNotifierProvider<SubmitMaidsFormNotifier, IsLoading>(
        (_) => SubmitMaidsFormNotifier());
