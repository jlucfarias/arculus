import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenVisibilityProvider extends ChangeNotifier with WidgetsBindingObserver {
  static const String _isTokenVisibleKey = 'is_token_visible';

  bool _isTokenVisible = false;

  bool get isTokenVisible => _isTokenVisible;

  TokenVisibilityProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    final settings = await SharedPreferences.getInstance();
    final tokenVisibility = settings.getBool(_isTokenVisibleKey);

    if (tokenVisibility != null) {
      _isTokenVisible = tokenVisibility;

      notifyListeners();
    }
  }

  Future<void> toggleTokenVisibility() async {
    _isTokenVisible = !_isTokenVisible;

    notifyListeners();

    final settings = await SharedPreferences.getInstance();

    await settings.setBool(_isTokenVisibleKey, _isTokenVisible);
  }
}
