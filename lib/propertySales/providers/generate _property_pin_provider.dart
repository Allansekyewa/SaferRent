import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final generateandReturnProvider =
    FutureProvider.family<String, String>((ref, passCode) async {
  try {
    final doc = await _firestore
        .collection(FirebaseCollectionName.passco)
        .where(FirebaseFieldNames.passCode, isEqualTo: passCode)
        .get();
    if (doc.docs.isNotEmpty) {
      final generatedPass = generatePass();
      return generatedPass;
    } else {
      throw ("passcode not found");
    }
  } catch (e) {
    throw ("Access Denied 😹😜");
  }
});
String generatePass() {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();

  final pin = StringBuffer();
  for (var i = 0; i <= 18; i++) {
    pin.write(chars[random.nextInt(chars.length)]);
  }

  return pin.toString();
}

final genearatedPassProvider =
    StateNotifierProvider<GeneratedPassNotifier, IsLoading>(
  (_) => GeneratedPassNotifier(),
);

class GeneratedPassNotifier extends StateNotifier<IsLoading> {
  GeneratedPassNotifier() : super(false);
  set isLoading(bool value) => state = value;

  String generatePass() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();

    final pin = StringBuffer();
    for (var i = 0; i <= 18; i++) {
      pin.write(chars[random.nextInt(chars.length)]);
    }

    return pin.toString();
  }
}
