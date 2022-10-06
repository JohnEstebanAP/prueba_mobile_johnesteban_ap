import 'package:flutter/material.dart';

class ThemeLight {
  static const Color colorPrimary = Color(0xffED1D24);

  static const Color colorCardPeli = Colors.red;

  static const Color colorDard = Color(0xff202020);

  static final ThemeData themeLight = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.grey[300],
      appBarTheme: const AppBarTheme(elevation: 0, color: colorDard),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: colorPrimary),
      );
}


class ThemeDark {
  static const Color colorPrimary = Color(0xffED1D24);

  static const Color colorCardPeli = Colors.red;

  static const Color colorDard = Color(0xff202020);

  static final ThemeData themeDark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.grey[300],
    appBarTheme: const AppBarTheme(elevation: 0, color: colorDard),
    floatingActionButtonTheme:
    const FloatingActionButtonThemeData(backgroundColor: colorPrimary),
  );
}