import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';

@immutable
class Movers {
  final String companyName;
  final String names;
  final String phoneNumber;
  final String location;
  final DateTime createdAt;
  Movers(Map<String, dynamic> json)
      : companyName = json[FirebaseCollectionName.movers],
        phoneNumber = json[FirebaseFieldNames.phoneNumber],
        location = json[FirebaseFieldNames.loc],
        names = json[FirebaseFieldNames.names],
        createdAt = (json[FirebaseFieldNames.createdAt] as Timestamp).toDate();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movers &&
          runtimeType == other.runtimeType &&
          companyName == other.companyName &&
          phoneNumber == other.phoneNumber &&
          names == other.names &&
          createdAt == other.createdAt;
  @override
  int get hashCode =>
      Object.hashAll([companyName, phoneNumber, location, names, createdAt]);
}
