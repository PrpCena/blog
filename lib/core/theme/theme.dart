// ignore_for_file: prefer_const_constructors

import 'package:clean/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: AppBarTheme(backgroundColor: AppPallete.backgroundColor),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(27),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppPallete.borderColor,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
