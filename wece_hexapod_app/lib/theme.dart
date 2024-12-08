import 'package:flutter/material.dart';

/*
 Here is where we will constants relating to the theme of our app, such as
 color scheme, font settings, and other UI objects as necessary
 */

class AppColors {
  // Flutter colors are RGB color codes prefixed with an opacity value.
  // The FF represents full opacity
  //LOGO colors
  static const orange = Color(0xFFEB8a2D);
  static const blue = Color(0xFFD6F4FF);
  static const yellow1 = Color(0xFFFDE74C);
  static const brown = Color(0xFF6C492B);
  static const yellow2 = Color(0xFFEEBF29);
  static const purple = Color(0xFF10074C);
  static const pink = Color(0xFFCD66BB);
  static const cream = Color(0xFFF7F4DB);
  static const mauve = Color(0xFF67386C);

  //extras
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const blue2 = Color(0xFF99dbf2);

}

ColorScheme colorScheme = const ColorScheme.dark(
  primary: AppColors.orange,
  onPrimary: AppColors.black,
  secondary: AppColors.yellow1,
  onSecondary: AppColors.black,
  surface: AppColors.mauve,
);
final appTheme = ThemeData.from(
    colorScheme: colorScheme
);