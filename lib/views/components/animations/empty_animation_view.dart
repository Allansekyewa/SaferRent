import 'package:flutter/material.dart';
import 'package:saferent/views/components/animations/empty_animation.dart';

class EmptyContentsAnimationzwords extends StatelessWidget {
  final text;
  const EmptyContentsAnimationzwords({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                text,
                style: const TextStyle(fontSize: 10),
              ),
            ),

            ///change this line below if i want to change images to animations
            const EmptyAnimation()
            //Image.asset('assets/cartoonsad.jpeg'),
          ],
        ),
      ),
    );
  }
}
