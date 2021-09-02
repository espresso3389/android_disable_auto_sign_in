import 'dart:async';

import 'package:flutter/services.dart';

/// Provides a way to disable Google Smart Lock on the next sign in.
abstract class AndroidDisableAutoSignIn {
  static const MethodChannel _channel = MethodChannel('android_disable_auto_sign_in');

  /// Stop Google Smart Lock to sign in automatically.
  static Future<void> smartLockSignOut() => _channel.invokeMethod('smartLockSignOut');
}
