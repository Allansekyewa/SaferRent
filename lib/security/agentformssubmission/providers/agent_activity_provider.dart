import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/security/agentformssubmission/models/agentactivity.dart';
import 'package:saferent/security/agentformssubmission/notifiers/agentActivity_notifier.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

final agentActivityProvider =
    StateNotifierProvider<SaveAgentActivityNotifier, IsLoading>(
        (_) => SaveAgentActivityNotifier());
