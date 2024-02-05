import 'package:flutter/foundation.dart' show immutable;

typedef Closeloadingscreen = bool Function();
typedef UpdateloadingScreen = bool Function(String text);

@immutable
class LoadingScreenController {
  final Closeloadingscreen close;
  final UpdateloadingScreen update;

  const LoadingScreenController({required this.close, required this.update});
}
