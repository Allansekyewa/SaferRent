import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final generateAgentsActPinProvider =
    FutureProvider.family<String, String>((ref, agentrefid) async {
  try {
    final doc = await _firestore
        .collection(FirebaseCollectionName.agentrefi)
        .where(FirebaseFieldNames.agentref, isEqualTo: agentrefid)
        .get();
    if (doc.docs.isNotEmpty) {
      final generatedAgentActPin = generateAgentActPin();
      return generatedAgentActPin;
    } else {
      throw ('Agent ref Id Not Found');
    }
  } catch (e) {
    throw ('Not An Agent Please 😂😎 chill');
  }
});
String generateAgentActPin() {
  const chars =
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  final random = Random();
  final pin = StringBuffer();
  for (var i = 0; i <= 20; i++) {
    pin.write(chars[random.nextInt(chars.length)]);
  }
  return pin.toString();
}
