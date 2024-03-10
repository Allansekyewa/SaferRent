import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_field_names.dart';

@immutable
class AgentActivity {
  final String refId;
  AgentActivity(Map<String, dynamic> json)
      : refId = json[FirebaseFieldNames.agentref];
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgentActivity &&
          runtimeType == other.runtimeType &&
          refId == other.refId;
  @override
  int get hashCode => Object.hashAll([refId]);
}
