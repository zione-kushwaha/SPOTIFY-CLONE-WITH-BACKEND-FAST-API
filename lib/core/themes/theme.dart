import 'package:day6/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _outlineInputBorder(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Pallete.whiteColor),
      enabledBorder: _outlineInputBorder(Pallete.borderColor),
      focusedBorder: _outlineInputBorder(Pallete.gradient2),
    ),
  );
}
