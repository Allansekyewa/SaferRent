import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/feedback/models/feedback.dart';
import 'package:saferent/state/posts/models/post.dart';

@immutable
class PostWithFeedback {
  final Post post;
  final Iterable<FeedBack> feedbacks;
  const PostWithFeedback({
    required this.post,
    required this.feedbacks,
  });
  @override
  bool operator ==(covariant PostWithFeedback other) =>
      post == other.post &&
      const IterableEquality().equals(feedbacks, other.feedbacks);
  @override
  int get hashCode => Object.hashAll([post, feedbacks]);
}
