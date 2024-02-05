import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_field_names.dart';

@immutable
class ReportsPayload extends MapView<String, dynamic> {
  ReportsPayload({
    required String report,
    required DateTime createdAt,
  }) : super({
          FirebaseFieldNames.rep: report,
          FirebaseFieldNames.createdAt: FieldValue.serverTimestamp(),
        });
}
