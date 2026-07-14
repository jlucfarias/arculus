import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:arculus/utils/app_theme.dart';

class ThemeProvider extends ChangeNotifier with WidgetsBindingObserver {
  AppTheme _currentTheme = const AppTheme(AppThemeMode.dark);

  AppTheme get currentTheme => _currentTheme;
  AppThemeMode get currentThemeMode => _currentTheme.mode;

  ThemeProvider() {
    WidgetsBinding.instance.addObserver(this);
    _syncTheme();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    _syncTheme();
  }

  Future<void> setTheme(String mode) async {
    if (mode == 'system') {
      _updateSystemTheme();
    } else {
      final selectedMode = AppThemeMode.values.byName(mode);

      if (_currentTheme.mode == selectedMode) {
        return;
      }

      _currentTheme = AppTheme(selectedMode);
    }

    notifyListeners();

    final settings = await SharedPreferences.getInstance();

    await settings.setString('theme_mode', mode);
  }

  List<AppTheme> get allThemes =>
      AppThemeMode.values.map((m) => AppTheme(m)).toList();

  Future<void> _syncTheme() async {
    final settings = await SharedPreferences.getInstance();
    final themeMode = settings.getString('theme_mode') ?? 'dark';

    if (themeMode == 'system') {
      _updateSystemTheme();
    } else {
      _currentTheme = AppTheme(AppThemeMode.values.byName(themeMode));
    }

    notifyListeners();
  }

  void _updateSystemTheme() {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    if (brightness == Brightness.dark) {
      _currentTheme = AppTheme(AppThemeMode.dark);
    } else {
      _currentTheme = AppTheme(AppThemeMode.light);
    }
  }
}
