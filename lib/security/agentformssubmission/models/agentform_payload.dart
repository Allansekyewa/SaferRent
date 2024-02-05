import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/security/agentformssubmission/typedefs/agentform_id.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

@immutable
class AgentsFormPayLoad extends MapView<String, dynamic> {
  AgentsFormPayLoad(
      {required String names,
      required String location,
      required DateTime createdAt,
      required String email,
      required String phoneNumber,
      required String ninNumber,
      required String educationLevel,
      required String refNo,
      required UserId userId,
      required AgentFormId formId})
      : super({
          FirebaseFieldNames.nin: ninNumber,
          FirebaseFieldNames.phoneNumber: phoneNumber,
          FirebaseFieldNames.refphone: refNo,
          FirebaseFieldNames.email: email,
          FirebaseFieldNames.educ: educationLevel,
          FirebaseFieldNames.names: names,
          FirebaseFieldNames.loc: location,
          FirebaseFieldNames.createdAt: FieldValue.serverTimestamp(),
        });
}
