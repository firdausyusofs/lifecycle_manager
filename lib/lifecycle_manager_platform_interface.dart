import 'package:lifecycle_manager/models/lifecycle.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'lifecycle_manager_method_channel.dart';

abstract class LifecycleManagerPlatform extends PlatformInterface {
  /// Constructs a LifecycleManagerPlatform.
  LifecycleManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static LifecycleManagerPlatform _instance = MethodChannelLifecycleManager();

  /// The default instance of [LifecycleManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelLifecycleManager].
  static LifecycleManagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LifecycleManagerPlatform] when
  /// they register themselves.
  static set instance(LifecycleManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Lifecycle> getApplicationLifecycle() {
    throw UnimplementedError('applicationLifecycle() has not been implemented.');
  }
}
