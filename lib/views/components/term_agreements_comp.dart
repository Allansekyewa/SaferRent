import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:saferent/views/main/terms_and_agreements.dart';

class TermsAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'By Logging Into SafeRents We Guarantee You\'ve Read and Agreed To Our',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              height: 1.5,
              wordSpacing: 0.8,
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        RichText(
          text: TextSpan(
            text: 'Terms and Agreements',
            style: const TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.red,
                fontSize: 12,
                wordSpacing: 1,
                fontWeight: FontWeight.normal),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const TermsAndAgreements()));
              },
            children: const [
              TextSpan(
                text: ' ',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
