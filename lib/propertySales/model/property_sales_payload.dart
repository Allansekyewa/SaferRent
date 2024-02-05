import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_field_names.dart';

@immutable
class PropertySalesPayload extends MapView<String, dynamic> {
  PropertySalesPayload({
    required String location,
    required String phoneNumber,
    required DateTime submittedAt,
    required String names,
    required String description,
    required String type,
  }) : super({
          FirebaseFieldNames.createdAt: FieldValue.serverTimestamp(),
          FirebaseFieldNames.descr: description,
          FirebaseFieldNames.loc: location,
          FirebaseFieldNames.phoneNumber: phoneNumber,
          FirebaseFieldNames.type: type,
          FirebaseFieldNames.names: names
        });
}
