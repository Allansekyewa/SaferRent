import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';

@immutable
class Reports {
  final String report;
  final DateTime createdAt;
  Reports(Map<String, dynamic> json)
      : report = json[FirebaseCollectionName.reports],
        createdAt = (json[FirebaseFieldNames.createdAt] as Timestamp).toDate();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Reports &&
          runtimeType == other.runtimeType &&
          report == other.report &&
          createdAt == other.createdAt;
  @override
  int get hashCode => Object.hashAll([report, createdAt]);
}
