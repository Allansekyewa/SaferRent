import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/payments/typedefs/payment_id.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/posts/typedefs/post_id.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

@immutable
class ProcessPaymentsPayload extends MapView<String, dynamic> {
  ProcessPaymentsPayload(
      {required PaymentId id,
      required String agentPhoneNumber,
      required String serviceProvider,
      required String paymentFor,
      required PostId onPostId,
      required double amount,
      required UserId fromUserId,
      required String clientsName,
      required String reason})
      : super({
          FirebaseFieldNames.clientNmaes: clientsName,
          FirebaseFieldNames.amount: amount,
          FirebaseFieldNames.paidAt: FieldValue.serverTimestamp(),
          FirebaseFieldNames.userId: fromUserId,
          FirebaseFieldNames.postId: onPostId,
          FirebaseFieldNames.paymentFor: paymentFor,
          FirebaseFieldNames.paymentId: id,
          FirebaseFieldNames.reaso: reason
        });
}
