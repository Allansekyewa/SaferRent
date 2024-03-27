import 'dart:math';

import 'package:riverpod/riverpod.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final generateAndReturnPinProvider =
    FutureProvider.family<String, String>((ref, phoneNumber) async {
  try {
    final existingDoc = await _firestore
        .collection(FirebaseCollectionName.verified)
        .where(FirebaseFieldNames.phoneNumber, isEqualTo: phoneNumber)
        .get();

    if (existingDoc.docs.isNotEmpty) {
      final generatedPin = generatePin();
      return generatedPin;
    } else {
      throw ("Phone number not found in Firestore");
    }
  } catch (e) {
    throw ("Not Authorized For This Service😉🤣👊");
  }
});

String generatePin() {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();

  final pin = StringBuffer();
  for (var i = 0; i <= 18; i++) {
    pin.write(chars[random.nextInt(chars.length)]);
  }

  return pin.toString();
}

final generatePinProvider =
    StateNotifierProvider<GeneratePinNotifier, IsLoading>(
  (_) => GeneratePinNotifier(),
);

class GeneratePinNotifier extends StateNotifier<IsLoading> {
  GeneratePinNotifier() : super(false);
  set isLoading(bool value) => state = value;

  String generatePin() {
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
