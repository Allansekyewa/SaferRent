import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

@immutable
class TenantsPayLoad extends MapView<String, dynamic> {
  TenantsPayLoad(
      {required UserId fromUserId,
      required String names,
      required String phoneNumber,
      required String location,
      required String unitNumber,
      required String ninNumber,
      required String rentAmount,
      required String email,
      required String landLordRef})
      : super({
          FirebaseFieldNames.userId: fromUserId,
          FirebaseFieldNames.amount: rentAmount,
          FirebaseFieldNames.email: email,
          FirebaseFieldNames.landlordRef: landLordRef,
          FirebaseFieldNames.loc: location,
          FirebaseFieldNames.names: names,
          FirebaseFieldNames.nin: ninNumber,
          FirebaseFieldNames.phoneNumber: phoneNumber,
          FirebaseFieldNames.unitNo: unitNumber,
          FirebaseFieldNames.createdAt: FieldValue.serverTimestamp(),
        });
}
