import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/security/agentformssubmission/typedefs/agentform_id.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

@immutable
class AgentForm {
  final AgentFormId id;
  final DateTime createdAt;
  final UserId fromUserId;
  AgentForm(Map<String, dynamic> json, {required this.id})
      : createdAt = (json[FirebaseFieldNames.createdAt] as Timestamp).toDate(),
        fromUserId = json[FirebaseFieldNames.userId];
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgentForm &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          createdAt == other.createdAt &&
          fromUserId == other.fromUserId;
  @override
  int get hashCode => Object.hashAll([id, createdAt, fromUserId]);
}
