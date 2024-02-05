import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_field_names.dart';

@immutable
class HouseMaidPayload extends MapView<String, dynamic> {
  HouseMaidPayload({
    required String names,
    required String phoneNumber,
    required String handlerName,
    required String handlersPhone,
    required String description,
    required DateTime createdAt,
  }) : super({
          FirebaseFieldNames.names: names,
          FirebaseFieldNames.descr: description,
          FirebaseFieldNames.handlerNam: handlerName,
          FirebaseFieldNames.handlersPh: handlersPhone,
          FirebaseFieldNames.createdAt: FieldValue.serverTimestamp(),
          FirebaseFieldNames.phoneNumber: phoneNumber
        });
}
