import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/payments/typedefs/payment_id.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/posts/typedefs/post_id.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

@immutable
class Payments {
  final PaymentId id;
  final double amount;
  final DateTime paidAt;
  final UserId fromUserId;
  final PostId onPostId;
  final String serviceProvider;
  final String paymentFor;
  final String clientNames;
  final String reason;

  Payments(Map<String, dynamic> json, this.paymentFor,
      {required this.id,
      required PostId onPostId,
      required UserId fromUserId,
      required String serviceProvider,
      required DateTime paidAt,
      required double amount,
      required String reason,
      required String clientName,
      required String paymnentFor})
      : amount = json[FirebaseFieldNames.amount],
        paidAt = (json[FirebaseFieldNames.paidAt] as Timestamp).toDate(),
        fromUserId = json[FirebaseFieldNames.userId],
        onPostId = json[FirebaseFieldNames.postId],
        serviceProvider = json[FirebaseFieldNames.servicePro],
        clientNames = json[FirebaseFieldNames.clientNmaes],
        reason = json[FirebaseFieldNames.reaso];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Payments &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          amount == other.amount &&
          paidAt == other.paidAt &&
          fromUserId == other.fromUserId &&
          onPostId == other.onPostId &&
          clientNames == other.clientNames &&
          reason == other.reason &&
          paymentFor == other.paymentFor;

  @override
  int get hashCode => Object.hashAll([
        id,
        amount,
        fromUserId,
        onPostId,
        paidAt,
        paymentFor,
        serviceProvider,
        clientNames,
        reason
      ]);
}
