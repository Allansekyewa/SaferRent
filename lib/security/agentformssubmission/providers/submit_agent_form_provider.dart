import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/security/agentformssubmission/notifiers/submit_agent_form_notifier.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

final submitAgentFormProvider =
    StateNotifierProvider<SubmitAgentFormNotifier, IsLoading>(
  (_) => SubmitAgentFormNotifier(),
);
