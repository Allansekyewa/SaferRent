import 'package:flutter/material.dart';
import 'package:saferent/views/components/animations/no_cart.dart';

class NoCartAnimationWords extends StatelessWidget {
  final text;
  const NoCartAnimationWords({super.key, this.text});

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
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black, fontSize: 10),
              ),
            ),
            const NocartAnimation(),
          ],
        ),
      ),
    );
  }
}
