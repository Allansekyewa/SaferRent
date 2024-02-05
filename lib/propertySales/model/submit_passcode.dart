import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';

@immutable
class SubmitPassCode {
  final String passCode;
  final DateTime createdAt;
  SubmitPassCode(Map<String, dynamic> json)
      : passCode = json[FirebaseCollectionName.passco],
        createdAt = (json[FirebaseFieldNames.createdAt] as Timestamp).toDate();
}
