package com.fariasopensourcery.arculus.platform.security

import android.app.Activity
import android.content.Context
import android.content.SharedPreferences
import android.content.pm.ApplicationInfo
import android.view.WindowManager

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class ScreenSecurityPlugin :
  FlutterPlugin,
  ActivityAware,
  MethodChannel.MethodCallHandler {

  companion object {
    private const val CHANNEL = "com.fariasopensourcery.arculus/screen_security"
    private const val PREF_NAME = "screen_security"
    private const val KEY_ENABLED = "enabled"
  }

  private lateinit var preferences: SharedPreferences

  private var channel: MethodChannel? = null
  private var activity: Activity? = null

  override fun onAttachedToEngine(
    binding: FlutterPlugin.FlutterPluginBinding
  ) {
    val appContext = binding.applicationContext

    defaultSecureEnabled =
      (appContext.applicationInfo.flags and ApplicationInfo.FLAG_DEBUGGABLE) == 0

    preferences = appContext.getSharedPreferences(
      PREF_NAME,
      Context.MODE_PRIVATE
    )

    channel = MethodChannel(
      binding.binaryMessenger,
      CHANNEL
    ).also {
      it.setMethodCallHandler(this)
    }
  }

  override fun onDetachedFromEngine(
    binding: FlutterPlugin.FlutterPluginBinding
  ) {
    channel?.setMethodCallHandler(null)
    channel = null
    activity = null
  }

  override fun onAttachedToActivity(
    binding: ActivityPluginBinding
  ) {
    activity = binding.activity
    applySavedPreference()
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(
    binding: ActivityPluginBinding
  ) {
    activity = binding.activity
    applySavedPreference()
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  private var defaultSecureEnabled: Boolean = true

  private fun isSecureEnabled(): Boolean {
    return preferences.getBoolean(KEY_ENABLED, defaultSecureEnabled)
  }

  private fun setSecureEnabled(enabled: Boolean) {
    preferences.edit()
      .putBoolean(KEY_ENABLED, enabled)
      .apply()

    applySecureFlag(enabled)
  }

  private fun applySavedPreference() {
    applySecureFlag(isSecureEnabled())
  }

  private fun applySecureFlag(enabled: Boolean) {
    val currentActivity = activity ?: return

    if (enabled) {
      currentActivity.window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
    } else {
      currentActivity.window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
    }
  }

  override fun onMethodCall(
    call: MethodCall,
    result: MethodChannel.Result
  ) {
    when (call.method) {
      "getEnabled" -> {
        result.success(isSecureEnabled())
      }
      "setEnabled" -> {
        val enabled = call.argument<Boolean>("enabled")

        if (enabled == null) {
          result.error(
            "INVALID_ARGUMENT",
            "The enabled argument is required",
            null
          )

          return
        }

        setSecureEnabled(enabled)
        result.success(null)
      }

      else -> result.notImplemented()
    }
  }
}
