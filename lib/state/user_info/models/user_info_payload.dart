import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

@immutable
class UserInfoPayLoad extends MapView<String, String> {
  UserInfoPayLoad({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) : super({
          FirebaseFieldNames.userId: userId,
          FirebaseFieldNames.displayName: displayName ?? '',
          FirebaseFieldNames.email: email ?? ''
        });
}
