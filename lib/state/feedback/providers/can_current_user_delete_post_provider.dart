import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/auth/providers/user_id_provider.dart';
import 'package:saferent/state/posts/models/post.dart';

final canCurrentUserDeletePostProvider =
    StreamProvider.family.autoDispose<bool, Post>((
  ref,
  Post post,
) async* {
  final userId = ref.watch(userIdProvider);
  yield userId == post.userId;
});
