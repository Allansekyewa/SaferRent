import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

@immutable
class LandLord {
  final String names;
  final UserId fromUserId;
  final String phoneNumber;
  final String banckAccount;
  final String refId;
  final String unitNos;
  final String location;
  final String email;

  LandLord(
    Map<String, dynamic> json,
  )   : names = json[FirebaseCollectionName.landlord],
        phoneNumber = json[FirebaseFieldNames.phoneNumber],
        refId = json[FirebaseFieldNames.landlordRef],
        unitNos = json[FirebaseFieldNames.unitNo],
        location = json[FirebaseFieldNames.loc],
        email = json[FirebaseFieldNames.email],
        fromUserId = json[FirebaseFieldNames.userId],
        banckAccount = json[FirebaseFieldNames.bankAcc];
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LandLord &&
          runtimeType == other.runtimeType &&
          fromUserId == other.fromUserId &&
          names == other.names &&
          phoneNumber == other.phoneNumber &&
          refId == other.refId &&
          email == other.email &&
          banckAccount == other.banckAccount &&
          location == other.location &&
          unitNos == other.unitNos;
  @override
  int get hashCode => Object.hashAll([
        refId,
        names,
        fromUserId,
        location,
        email,
        unitNos,
        banckAccount,
        phoneNumber
      ]);
}
