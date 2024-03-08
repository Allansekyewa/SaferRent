import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/posts/typedefs/post_id.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

@immutable
class SeenBy extends MapView<String, String> {
  SeenBy(
      {required PostId postId, required UserId seenby, required DateTime date})
      : super({
          FirebaseFieldNames.postId: postId,
          FirebaseFieldNames.userId: seenby,
          FirebaseFieldNames.date: date.toIso8601String()
        });
}
