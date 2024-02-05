import 'package:flutter/material.dart';
import 'package:saferent/views/components/animations/real_estate.dart';

class RealEstateAnimationzwords extends StatelessWidget {
  final text;
  const RealEstateAnimationzwords({super.key, required this.text});

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
            const RealEstateAnimation(),
          ],
        ),
      ),
    );
  }
}
