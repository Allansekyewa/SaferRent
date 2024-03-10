import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_field_names.dart';

@immutable
class AgentActivityPayload extends MapView<String, dynamic> {
  AgentActivityPayload({required String refId})
      : super({FirebaseFieldNames.agentref: refId});
}
