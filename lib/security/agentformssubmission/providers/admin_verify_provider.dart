import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/security/agentformssubmission/notifiers/adminphone_notifier.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

final verifyAdminProvider =
    StateNotifierProvider<SaveAdminPhoneNotifier, IsLoading>(
        (_) => SaveAdminPhoneNotifier());
