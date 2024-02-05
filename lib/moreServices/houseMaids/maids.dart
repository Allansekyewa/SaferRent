import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';

@immutable
class Maids {
  final String names;
  final String phoneNumber;
  final String handlersName;
  final String handlersPhone;
  final String description;
  final DateTime createdAt;

  Maids(Map<String, dynamic> json)
      : description = json[FirebaseCollectionName.houseMai],
        phoneNumber = json[FirebaseFieldNames.phoneNumber],
        handlersName = json[FirebaseFieldNames.descr],
        handlersPhone = json[FirebaseFieldNames.handlersPh],
        names = json[FirebaseFieldNames.names],
        createdAt = (json[FirebaseFieldNames.createdAt] as Timestamp).toDate();
}
