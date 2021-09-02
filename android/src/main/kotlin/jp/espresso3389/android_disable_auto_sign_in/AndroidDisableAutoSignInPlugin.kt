package jp.espresso3389.android_disable_auto_sign_in

import android.app.Activity
import androidx.annotation.NonNull
import com.google.android.gms.auth.api.credentials.Credential

import com.google.android.gms.auth.api.credentials.Credentials
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.google.android.gms.auth.api.signin.GoogleSignInOptions
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import java.lang.Exception

/** AndroidDisableAutoSignInPlugin */
class AndroidDisableAutoSignInPlugin: FlutterPlugin, ActivityAware, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var activity : Activity
  private val scope = CoroutineScope(Job() + Dispatchers.Main)

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "android_disable_auto_sign_in")
    channel.setMethodCallHandler(this)
  }

  override fun onAttachedToActivity(@NonNull binding: ActivityPluginBinding) {
    activity = binding.activity;
  }

  override fun onDetachedFromActivity() {
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }

  override fun onReattachedToActivityForConfigChanges(@NonNull binding: ActivityPluginBinding) {
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "smartLockSignOut") {
      scope.launch {
        try {
          // this will prevent smart lock from immediately re-logging in the user once signed out.
          // https://stackoverflow.com/a/55883159
          Credentials.getClient(activity).disableAutoSignIn()
          GoogleSignIn.getClient(activity, GoogleSignInOptions.DEFAULT_SIGN_IN).signOut()
          result.success(true)
        } catch (e: Exception) {
          result.success(false)
        }
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
