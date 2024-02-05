import 'package:riverpod/riverpod.dart';
import 'package:saferent/moreServices/movingServices/notifiers/movers_submit_notifier.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

final subitMoversFormProvider =
    StateNotifierProvider<SubmitMoverFormNotifier, IsLoading>(
        (_) => SubmitMoverFormNotifier());
