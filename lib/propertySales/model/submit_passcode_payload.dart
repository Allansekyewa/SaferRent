import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_field_names.dart';

@immutable
class SubmitPasscodePayload extends MapView<String, dynamic> {
  SubmitPasscodePayload({
    required String passcode,
  }) : super({FirebaseFieldNames.passCode: passcode});
}
