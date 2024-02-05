import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/image_upload/typedefs/is_loading.dart';

class GenerateAdminPinNotifier extends StateNotifier<IsLoading> {
  GenerateAdminPinNotifier() : super(false);
  set isLoading(bool value) => state = value;
}

String generateAdminPin() {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();

  final pin = StringBuffer();
  for (var i = 0; i <= 20; i++) {
    pin.write(chars[random.nextInt(chars.length)]);
  }

  return pin.toString();
}
