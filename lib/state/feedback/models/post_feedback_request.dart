import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/enums/date_sorting.dart';
import 'package:saferent/state/posts/typedefs/post_id.dart';

@immutable
class RequestsForPostAndFeedback {
  final PostId postId;
  final bool sortByCreatedAt;
  final DateSorting dateSorting;
  final int? limit;

  const RequestsForPostAndFeedback(
      {required this.postId,
      this.sortByCreatedAt = true,
      this.dateSorting = DateSorting.newestOnTop,
      this.limit});

  @override
  bool operator ==(covariant RequestsForPostAndFeedback other) =>
      postId == other.postId &&
      sortByCreatedAt == other.sortByCreatedAt &&
      dateSorting == other.dateSorting &&
      limit == other.limit;
  @override
  int get hashCode => Object.hashAll([
        postId,
        dateSorting,
        sortByCreatedAt,
        limit,
      ]);
}
