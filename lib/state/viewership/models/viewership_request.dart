import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/posts/typedefs/post_id.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

@immutable
class ViewershipRequest {
  final PostId postId;
  final UserId viewedby;
  const ViewershipRequest({
    required this.postId,
    required this.viewedby,
  });
}
