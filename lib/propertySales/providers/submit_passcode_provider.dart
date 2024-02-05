import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/propertySales/notifiers/submit_passcode_notifier.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

final submitPasscodeProvider =
    StateNotifierProvider<SubmitPasscodeNotifier, IsLoading>(
        (_) => SubmitPasscodeNotifier());
