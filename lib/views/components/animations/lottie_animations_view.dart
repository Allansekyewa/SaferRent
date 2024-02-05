import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:saferent/views/components/animations/models/lottie.dart';

class LottieAnimatioView extends StatelessWidget {
  final LottieAnimation animation;
  final bool repeat;
  final bool reverse;
  const LottieAnimatioView(
      {super.key,
      required this.animation,
      this.repeat = true,
      this.reverse = false});

  @override
  Widget build(BuildContext context) => Lottie.asset(
        animation.fullPath,
        reverse: reverse,
        repeat: repeat,
      );
}

extension GetFullPath on LottieAnimation {
  String get fullPath => "assets/animations/$name.json";
}
