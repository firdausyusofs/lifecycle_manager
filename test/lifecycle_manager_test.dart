import 'package:flutter_test/flutter_test.dart';
import 'package:lifecycle_manager/lifecycle_manager.dart';
import 'package:lifecycle_manager/lifecycle_manager_platform_interface.dart';
import 'package:lifecycle_manager/lifecycle_manager_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLifecycleManagerPlatform
    with MockPlatformInterfaceMixin
    implements LifecycleManagerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LifecycleManagerPlatform initialPlatform = LifecycleManagerPlatform.instance;

  test('$MethodChannelLifecycleManager is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLifecycleManager>());
  });

  test('getPlatformVersion', () async {
    LifecycleManager lifecycleManagerPlugin = LifecycleManager();
    MockLifecycleManagerPlatform fakePlatform = MockLifecycleManagerPlatform();
    LifecycleManagerPlatform.instance = fakePlatform;

    expect(await lifecycleManagerPlugin.getPlatformVersion(), '42');
  });
}
