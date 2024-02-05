import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/auth/modesls/auth_state.dart';
import 'package:saferent/state/auth/notifiers/auth_state_notifiers.dart';


final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
    (_) => AuthStateNotifier());
