import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/auth/modesls/auth_result.dart';
import 'package:saferent/state/auth/providers/auth_state_providers.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.successs;
});
