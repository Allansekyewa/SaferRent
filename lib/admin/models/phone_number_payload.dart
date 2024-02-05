import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_field_names.dart';

@immutable
class PhoneNumberPayLoad extends MapView<String, dynamic> {
  PhoneNumberPayLoad(
      {required String phoneNumber,
      required String agentId,
      required String refPhone,
      required DateTime cretaedAt,
      required String ninNumber})
      : super({
          FirebaseFieldNames.phoneNumber: phoneNumber,
          FirebaseFieldNames.agentId: agentId,
          FirebaseFieldNames.nin: ninNumber,
          FirebaseFieldNames.refphone: refPhone,
          FirebaseFieldNames.createdAt: FieldValue.serverTimestamp(),
        });
}
