import 'package:flutter/material.dart';

enum AppThemeMode {
  light,
  dark,
}

class ColorScheme {
  final Color primary;
  final Color background;

  const ColorScheme({
    required this.primary,
    required this.background,
  });
}

class AppTheme {
  final AppThemeMode mode;

  const AppTheme(this.mode);

  String get displayName => switch (mode) {
    AppThemeMode.light => 'Light',
    AppThemeMode.dark => 'Dark',
  };

  ColorScheme get colors => switch (mode) {
    AppThemeMode.light => ColorScheme(
      primary: Color(0xFF1868DB),
      background: Color(0xFFFFFFFF),
    ),
    AppThemeMode.dark => ColorScheme(
      primary: Color(0xFF669DF1),
      background: Color(0xFF1F1F21),
    ),
  };
}
