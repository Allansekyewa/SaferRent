import 'package:flutter/material.dart';

class AgentsAnimationzwords extends StatelessWidget {
  final text;
  const AgentsAnimationzwords({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                text,
                style: const TextStyle(fontSize: 10),
              ),
            ),
            Image.asset(
              'assets/bossbany.jpg',
              height: 380,
            )
          ],
        ),
      ),
    );
  }
}
