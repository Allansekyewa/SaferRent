import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';

@immutable
class PropertySales {
  final DateTime createdAt;
  final String location;
  final String type;
  final String contacts;
  final String description;
  final String names;
  PropertySales(Map<String, dynamic> json)
      : type = json[FirebaseCollectionName.propertySales],
        createdAt = (json[FirebaseFieldNames.createdAt] as Timestamp).toDate(),
        location = json[FirebaseFieldNames.loc],
        contacts = json[FirebaseFieldNames.phoneNumber],
        names = json[FirebaseFieldNames.names],
        description = json[FirebaseFieldNames.descr];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PropertySales &&
          runtimeType == other.runtimeType &&
          location == other.location &&
          type == other.type &&
          contacts == other.contacts &&
          description == other.description &&
          names == other.names &&
          createdAt == other.createdAt;
  @override
  int get hashCode =>
      Object.hashAll([location, type, contacts, description, createdAt, names]);
}
