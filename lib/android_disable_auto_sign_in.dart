
import 'dart:async';

import 'package:flutter/services.dart';

class AndroidDisableAutoSignIn {
  static const MethodChannel _channel = MethodChannel('android_disable_auto_sign_in');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
