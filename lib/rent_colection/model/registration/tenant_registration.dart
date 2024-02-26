import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

@immutable
class TenantRegistration {
  final String names;

  final String phoneNumber;
  final String landlordRef;
  final UserId fromUserId;
  final String email;
  final String ninNumber;
  final String location;
  final String unitNumber;
  final String rentAMount;
  final DateTime createdAt;
  TenantRegistration(
    Map<String, dynamic> json,
  )   : names = json[FirebaseCollectionName.tenantReg],
        phoneNumber = json[FirebaseFieldNames.phoneNumber],
        landlordRef = json[FirebaseFieldNames.landlordRef],
        fromUserId = json[FirebaseFieldNames.userId],
        email = json[FirebaseFieldNames.email],
        location = json[FirebaseFieldNames.loc],
        unitNumber = json[FirebaseFieldNames.unitNo],
        rentAMount = json[FirebaseFieldNames.amount],
        createdAt = (json[FirebaseFieldNames.createdAt] as Timestamp).toDate(),
        ninNumber = json[FirebaseFieldNames.nin];
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TenantRegistration &&
          runtimeType == other.runtimeType &&
          names == other.names &&
          phoneNumber == other.phoneNumber &&
          landlordRef == other.landlordRef &&
          fromUserId == other.fromUserId &&
          email == other.email &&
          ninNumber == other.ninNumber &&
          location == other.location &&
          unitNumber == other.unitNumber &&
          rentAMount == other.rentAMount &&
          createdAt == other.createdAt;
  @override
  int get hashCode => Object.hashAll([
        landlordRef,
        rentAMount,
        ninNumber,
        phoneNumber,
        names,
        location,
        unitNumber,
        createdAt,
        fromUserId
      ]);
}
