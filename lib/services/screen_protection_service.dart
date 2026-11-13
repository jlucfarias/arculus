import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ScreenProtectionService {
  static const MethodChannel _channel = MethodChannel(
    'com.fariasopensourcery.arculus/screen_security',
  );

  static bool get isSupported =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static Future<bool> getEnabled() async {
    if (!isSupported) return false;

    return await _channel.invokeMethod<bool>('getEnabled') ?? false;
  }

  static Future<void> setEnabled(bool enabled) async {
    if (!isSupported) return;

    await _channel.invokeMethod<void>('setEnabled', {'enabled': enabled});
  }
}
