import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        colorSchemeSeed: Color.fromARGB(255, 40, 132, 189),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}
