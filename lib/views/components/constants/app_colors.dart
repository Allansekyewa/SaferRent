import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/extensions/string/as_html_color_to_color.dart';

@immutable
class AppColors {
  static final butttonColor = '#cfc9c2'.htmlColorToColor();
  static const loginButttonTextColor = 'Colors.Black';
  static final gooleColor = '#4285f4'.htmlColorToColor();
  static final appleColor = '#3b5998'.htmlColorToColor();
  static const twitterColor = "Colors.White";
  const AppColors._();
}
