import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/posts/typedefs/post_id.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

@immutable
class CartPayload extends MapView<String, dynamic> {
  CartPayload(
      {required UserId fromuserId,
      required PostId onPostId,
      required String description,
      required String thuumbnail})
      : super({
          FirebaseFieldNames.userId: fromuserId,
          FirebaseFieldNames.postId: onPostId,
          FirebaseFieldNames.descr: description,
          FirebaseFieldNames.thumb: thuumbnail,
          FirebaseFieldNames.createdAt: FieldValue.serverTimestamp(),
        });
}
