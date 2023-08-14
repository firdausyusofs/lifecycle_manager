package com.fy.lifecycle_manager

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** LifecycleManagerPlugin */
class LifecycleManagerPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var lifecycleService: LifecycleService

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "lifecycle_manager")
    channel.setMethodCallHandler(this)

    lifecycleService = LifecycleService()
  }

//  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
//    channel.setMethodCallHandler(null)
//  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when(call.method) {
      Keys.CHANNEL_METHOD_GET_APP_LIFE_CYCLE -> {
        methodGetAppLifeCycle(call, result)
      } else -> {
        result.notImplemented()
      }
    }
  }

  private fun methodGetAppLifeCycle(@NonNull call: MethodCall, @NonNull result: Result) {
    result.success(LifecycleService.getAppLifeCycle().value);
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
