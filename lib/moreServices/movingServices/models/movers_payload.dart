import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_field_names.dart';

@immutable
class MoversPayload extends MapView<String, dynamic> {
  MoversPayload(
      {required String companyName,
      required String phoneNumber,
      required String location,
      required String names,
      required DateTime createdAt})
      : super({
          FirebaseFieldNames.companNam: companyName,
          FirebaseFieldNames.createdAt: FieldValue.serverTimestamp(),
          FirebaseFieldNames.loc: location,
          FirebaseFieldNames.names: names,
          FirebaseFieldNames.phoneNumber: phoneNumber
        });
}
