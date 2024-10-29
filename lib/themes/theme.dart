import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData.dark().copyWith(
  appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900]),
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(selectedItemColor: Colors.green),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.green[800],
    foregroundColor: Colors.white,
  ),
  colorScheme: const ColorScheme.dark(
    primary: Colors.green,
  ),
  dividerColor: Colors.grey,
  scaffoldBackgroundColor: Colors.grey[900],
  primaryColorDark: Colors.grey[850],
);
