import 'package:flutter/material.dart';

class SearchAnimationViewWithWords extends StatelessWidget {
  final text;
  const SearchAnimationViewWithWords({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(text,
                  style: const TextStyle(
                    fontSize: 8,
                  )),
            ),
            Image.asset(
              'assets/cart2.png',
            )
          ],
        ),
      ),
    );
  }
}
