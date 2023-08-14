import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:lifecycle_manager/keys.dart';

import 'lifecycle_manager_platform_interface.dart';
import 'models/lifecycle.dart';

/// An implementation of [LifecycleManagerPlatform] that uses method channels.
class MethodChannelLifecycleManager extends LifecycleManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('lifecycle_manager');

  @override
  Future<Lifecycle> getApplicationLifecycle() async {
    final String? lifecycleStr = await methodChannel.invokeMethod(CHANNEL_METHOD_GET_APP_LIFE_CYCLE);
    return Lifecycle.values.firstWhere((element) => element.name == lifecycleStr);
  }

}
