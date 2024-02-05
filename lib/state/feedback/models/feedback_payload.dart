import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/posts/typedefs/post_id.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

@immutable
class FeedBackPayload extends MapView<String, dynamic> {
  FeedBackPayload({
    required UserId fromUserId,
    required PostId onPostId,
    required String feedback,
  }) : super({
          FirebaseFieldNames.userId: fromUserId,
          FirebaseFieldNames.postId: onPostId,
          FirebaseFieldNames.feedback: feedback,
          FirebaseFieldNames.createdAt: FieldValue.serverTimestamp(),
        });
}
