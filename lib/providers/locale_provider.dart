import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier with WidgetsBindingObserver {
  static const String _localeKey = 'locale';

  Locale? _locale;

  Locale? get locale => _locale;

  LocaleProvider() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final settings = await SharedPreferences.getInstance();
    final locale = settings.getString(_localeKey);

    if (locale != null && locale != 'sys') {
      _locale = Locale(locale);

      notifyListeners();
    } else {
      _locale = null;
    }
  }

  Future<void> setLocale(String locale) async {
    if (locale == 'sys' && _locale == null) {
      return;
    }

    if (_locale?.languageCode == locale) {
      return;
    }

    if (locale != 'sys') {
      _locale = Locale(locale);
    } else {
      _locale = null;
    }

    notifyListeners();

    final settings = await SharedPreferences.getInstance();

    await settings.setString(_localeKey, locale);
  }
}
