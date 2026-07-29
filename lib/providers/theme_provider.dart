import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier with WidgetsBindingObserver {
  static const String _themeModeKey = 'theme_mode';
  static const String _useAmoledKey = 'theme_use_amoled';

  ThemeMode _themeMode = ThemeMode.system;
  bool _useAmoled = false;

  ThemeMode get themeMode => _themeMode;
  bool get useAmoled => _useAmoled;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final settings = await SharedPreferences.getInstance();
    final themeMode = settings.getString(_themeModeKey);
    final useAmoled = settings.getBool(_useAmoledKey);

    if (themeMode != null) {
      _themeMode = ThemeMode.values.byName(themeMode);
      _useAmoled = useAmoled ?? false;

      notifyListeners();
    }
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

  Future<void> toggleAmoledUse() async {
    _useAmoled = !_useAmoled;

    notifyListeners();

    final settings = await SharedPreferences.getInstance();

    await settings.setBool(_useAmoledKey, _useAmoled);
  }
}
