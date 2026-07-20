import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier with WidgetsBindingObserver {
  static const String _themeModeKey = 'theme_mode';

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) {
      return;
    }

    _themeMode = mode;

    notifyListeners();

    final settings = await SharedPreferences.getInstance();

    await settings.setString(_themeModeKey, mode.name);
  }

  Future<void> _loadTheme() async {
    final settings = await SharedPreferences.getInstance();
    final saved = settings.getString(_themeModeKey);

    if (saved != null) {
      _themeMode = ThemeMode.values.byName(saved);

      notifyListeners();
    }
  }
}
