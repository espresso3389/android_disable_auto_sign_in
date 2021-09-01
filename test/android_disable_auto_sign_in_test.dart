import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:android_disable_auto_sign_in/android_disable_auto_sign_in.dart';

void main() {
  const MethodChannel channel = MethodChannel('android_disable_auto_sign_in');

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
    expect(await AndroidDisableAutoSignIn.platformVersion, '42');
  });
}
