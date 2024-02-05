import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final generateAdminandReturnPinProvider =
    FutureProvider.family<String, String>((ref, adminPhone) async {
  try {
    final doc = await _firestore
        .collection(FirebaseCollectionName.verifyad)
        .where(FirebaseFieldNames.adminph, isEqualTo: adminPhone)
        .get();
    if (doc.docs.isNotEmpty) {
      final generatedAdminPin = generateAdminPin();
      return generatedAdminPin;
    } else {
      throw ("Admin number not found");
    }
  } catch (e) {
    throw ("Your Not Authorized For This Service 🙅‍♂️😂🤸");
  }
});
String generateAdminPin() {
  const chars =
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  final random = Random();
  final pin = StringBuffer();
  for (var i = 0; i <= 20; i++) {
    pin.write(chars[random.nextInt(chars.length)]);
  }
  return pin.toString();
}
