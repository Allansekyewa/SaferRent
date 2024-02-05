import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/feedback/notifiers/delete_feedback_notifier.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

final deleteFeedbackProvider =
    StateNotifierProvider<DeleteFeedbackStateNotifier, IsLoading>(
        (_) => DeleteFeedbackStateNotifier());
