import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_field_names.dart';


@immutable
class AdminPhoneNumberPayLoad extends MapView<String, dynamic> {
  AdminPhoneNumberPayLoad({
    required String adminPhone,
  }) : super({FirebaseFieldNames.adminph: adminPhone});
}
