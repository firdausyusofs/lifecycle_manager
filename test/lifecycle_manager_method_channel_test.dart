import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecycle_manager/lifecycle_manager_method_channel.dart';

void main() {
  MethodChannelLifecycleManager platform = MethodChannelLifecycleManager();
  const MethodChannel channel = MethodChannel('lifecycle_manager');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
