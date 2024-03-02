import 'package:flutter/material.dart';
import 'package:saferent/views/components/constants/app_colors.dart';

class TextSplash extends StatefulWidget {
  TextSplash({Key? key});

  Color? backgroundColor;
  String? text;
  double? textWidth;
  double? textHeight;
  Gradient? gradient;

  @override
  State<TextSplash> createState() => _TextSplashState();
}

class _TextSplashState extends State<TextSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust duration as needed
    )..repeat(); // Repeats the animation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.butttonColor,
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            gradient: widget.gradient,
          ),
          child: Center(
            child: SizedBox(
              width: widget.textWidth,
              height: widget.textHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    'Safe',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RotationTransition(
                    turns: _controller,
                    child: const Text(
                      'R',
                      style: TextStyle(
                        fontSize: 68,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    'ents',
                    style: TextStyle(
                      fontSize: 34,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
