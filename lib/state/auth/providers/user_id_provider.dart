import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/auth/providers/auth_state_providers.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

final userIdProvider =
    Provider<UserId?>((ref) => ref.watch(authStateProvider).userId);
