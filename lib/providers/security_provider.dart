import 'package:arculus/services/screen_protection_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecurityProvider extends ChangeNotifier with WidgetsBindingObserver {
  static const String _preventScreenCaptureKey = "prevent_screen_capture";

  bool _preventScreenCapture = false;

  bool get isScreenCaptureBlocked => _preventScreenCapture;

  SecurityProvider() {
    _loadSecuritySettings();
  }

  Future<void> _loadSecuritySettings() async {
    final settings = await SharedPreferences.getInstance();
    final preventScreenCapture = settings.getBool(_preventScreenCaptureKey);

    _preventScreenCapture = preventScreenCapture ?? await ScreenProtectionService.getEnabled();

    notifyListeners();
  }

  Future<void> toggleScreenCapturePrevention() async {
    _preventScreenCapture = !_preventScreenCapture;

    notifyListeners();

    final settings = await SharedPreferences.getInstance();

    await settings.setBool(_preventScreenCaptureKey, _preventScreenCapture);
    await ScreenProtectionService.setEnabled(_preventScreenCapture);
  }
}
