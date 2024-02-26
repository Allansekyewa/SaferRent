import 'dart:collection';

import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

@immutable
class LandLordPayload extends MapView<String, dynamic> {
  LandLordPayload({
    required String names,
    required String phoneNumber,
    required String email,
    required String unitNos,
    required String location,
    required String bankAccount,
    required String refId,
    required UserId fromUserId,
  }) : super({
          FirebaseFieldNames.userId: fromUserId,
          FirebaseFieldNames.bankAcc: bankAccount,
          FirebaseFieldNames.email: email,
          FirebaseFieldNames.landlordRef: refId,
          FirebaseFieldNames.loc: location,
          FirebaseFieldNames.phoneNumber: phoneNumber,
          FirebaseFieldNames.unitNo: unitNos,
          FirebaseFieldNames.names: names
        });
}
