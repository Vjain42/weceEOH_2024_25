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
  // 2025 new theme color palette 
  static const pink = Color(0xFFCD66BB);
  static const darkishPink = Color.fromARGB(255, 160, 68, 145);
  static const darkPink = Color.fromARGB(255, 131, 34, 115);
  static const cream = Color(0xFFF7F4DB);
  static const mauve = Color(0xFF67386C);
  static const darkBlue = Color(0xFF170652);
  static const purple = Color(0xFF6D3ED2);
  static const deepPurple = Color(0xFF452589);
  static const indigo = Color(0xFF3A206D);
  static const grayishPurple = Color(0xFF4C456D);
  static const gray = Color(0xFF84848C);

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