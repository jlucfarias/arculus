package com.fariasopensourcery.arculus

import com.fariasopensourcery.arculus.platform.security.ScreenSecurityPlugin

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
  override fun configureFlutterEngine(
    flutterEngine: FlutterEngine
  ) {
    super.configureFlutterEngine(flutterEngine)

    val pluginRegistry = flutterEngine.getPlugins()

    if (!pluginRegistry.has(ScreenSecurityPlugin::class.java)) {
      pluginRegistry.add(ScreenSecurityPlugin())
    }
  }
}
