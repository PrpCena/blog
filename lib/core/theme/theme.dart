// ignore_for_file: prefer_const_constructors

import 'package:clean/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static OutlineInputBorder border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: AppBarTheme(backgroundColor: AppPallete.backgroundColor),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(27),
      focusedBorder: border(AppPallete.gradient1),
      enabledBorder: border(AppPallete.borderColor),
    ),
    chipTheme: ChipThemeData( 
      color: MaterialStatePropertyAll(AppPallete.backgroundColor), 
      side: BorderSide.none,
    )
  );
}
