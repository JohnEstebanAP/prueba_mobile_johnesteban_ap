import 'package:flutter/material.dart';

class ThemeLight {
  static const Color colorPrimary = Color(0xffED1D24);

  static const Color colorCardPeli = Colors.red;

  static final ThemeData themeLight = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.grey[300],
    appBarTheme: const AppBarTheme(elevation: 0, color: colorPrimary),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: colorPrimary),
  );
}
