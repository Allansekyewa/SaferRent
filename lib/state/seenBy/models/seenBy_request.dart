import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/posts/typedefs/post_id.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

@immutable
class SeenByRequest {
  final PostId postId;
  final UserId seenby;
  const SeenByRequest({required this.postId, required this.seenby});
}
