import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:saferent/security/agentformssubmission/providers/admin_verify_provider.dart';
import 'package:saferent/security/agentformssubmission/providers/submit_agent_form_provider.dart';
import 'package:saferent/security/agentformssubmission/providers/verify_phone_number_provider.dart';
import 'package:saferent/security/pinsentry/providers/generate_pin_provider.dart';
import 'package:saferent/state/auth/providers/auth_state_providers.dart';
import 'package:saferent/state/feedback/providers/delete_feedback_provider.dart';
import 'package:saferent/state/feedback/providers/send_feedback_provider.dart';
import 'package:saferent/state/image_upload/providers/image_uploader_provider.dart';
import 'package:saferent/state/posts/providers/delete_post_provider.dart';

final isLoadingProvider = Provider<bool>(
  (ref) {
    final authState = ref.watch(authStateProvider);
    final isUploadingImage = ref.watch(imageUploadProvider);
    final isSendingFeedback = ref.watch(sendFeedbackProvider);
    final isDeletingFeedback = ref.watch(deleteFeedbackProvider);
    final isDeletingPost = ref.watch(deletePostProvider);
    final isSubmittingAgentForm = ref.watch(submitAgentFormProvider);
    final isVerifyingAgent = ref.watch(verifyPhoneProvider);
    final isGeneratePin = ref.watch(generatePinProvider);

    final isSavingAdmin = ref.watch(verifyAdminProvider);

    return authState.isLoading ||
        isUploadingImage ||
        isDeletingPost ||
        isDeletingFeedback ||
        isSendingFeedback ||
        isSubmittingAgentForm ||
        isVerifyingAgent ||
        isGeneratePin ||
        isSavingAdmin;
  },
);
