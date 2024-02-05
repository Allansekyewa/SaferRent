import 'package:riverpod/riverpod.dart';
import 'package:saferent/security/agentformssubmission/notifiers/save_phone_notifier.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

final verifyPhoneProvider = StateNotifierProvider<SavePhoneNotifier, IsLoading>(
  (_) => SavePhoneNotifier(),
);
