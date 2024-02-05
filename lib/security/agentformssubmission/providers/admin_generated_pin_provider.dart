import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/security/agentformssubmission/notifiers/generate_admin_pin_notifier.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

final adminGeneratedPinProvider =
    StateNotifierProvider<GenerateAdminPinNotifier, IsLoading>(
        (_) => GenerateAdminPinNotifier());
