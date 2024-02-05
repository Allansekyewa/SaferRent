import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/feedback/notifiers/send_feedback_notifier.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';


final sendFeedbackProvider =
    StateNotifierProvider<SendFeedbackNotifier, IsLoading>(
  (_) => SendFeedbackNotifier(),
);
