import 'package:flutter/foundation.dart' show immutable, VoidCallback;
import 'package:flutter/material.dart' show TextStyle, Colors, TextDecoration;
import 'package:saferent/views/components/rich_text/linked_text.dart';

@immutable
class BaseText {
  final String text;
  final TextStyle? style;
  bool get isLinkText => this is LinkText;
  const BaseText({required this.text, this.style});
  factory BaseText.plain({
    required String text,
    TextStyle? style = const TextStyle(),
  }) =>
      BaseText(text: text, style: style);
  factory BaseText.link({
    required String text,
    required VoidCallback onTapped,
    TextStyle? style = const TextStyle(
      color: Colors.blue,
      fontSize: 13,
      decoration: TextDecoration.underline,
    ),
  }) =>
      LinkText(text: text, onTapped: onTapped, style: style);
}
