import 'package:flutter/material.dart';

class RichTwoPartsText extends StatelessWidget {
  final String leftPart;
  final String rightPart;
  const RichTwoPartsText(
      {super.key, required this.leftPart, required this.rightPart});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style:
              const TextStyle(color: Colors.black, height: 1.5, fontSize: 10),
          children: [
            TextSpan(
                text: leftPart,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 10)),
            TextSpan(
              text: ' \n $rightPart',
            )
          ]),
    );
  }
}
