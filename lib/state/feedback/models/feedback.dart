import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/feedback/typedefs/feedback_id.dart';
import 'package:saferent/state/posts/typedefs/post_id.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

@immutable
class FeedBack {
  final FeedBackId id;
  final String feedback;
  final DateTime createdAt;
  final UserId fromUserId;
  final PostId onPostId;

  FeedBack(Map<String, dynamic> json, {required this.id})
      : feedback = json[FirebaseCollectionName.feedback],
        createdAt = (json[FirebaseFieldNames.createdAt] as Timestamp).toDate(),
        fromUserId = json[FirebaseFieldNames.userId],
        onPostId = json[FirebaseFieldNames.postId];
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedBack &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          feedback == other.feedback &&
          createdAt == other.createdAt &&
          fromUserId == other.fromUserId &&
          onPostId == other.onPostId;
  @override
  int get hashCode => Object.hashAll([
        id,
        feedback,
        createdAt,
        fromUserId,
        onPostId,
      ]);
}
