# android_disable_auto_sign_in

This is a simple Flutter plugin to disable Android Smart Lock auto-sign-in.

## Introduction

When you use [flutter_auth_ui](https://pub.dev/packages/flutter_auth_ui) with `enableSmartLock` on, the credential is saved on Firebase's credential store and it can be deleted using [FirebaseAuth.instance.signOut](https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signOut.html).

But on the next signing in, Google Smart Lock automatically signs in using the last used credential and it results in infinite signing in loop as described [here](https://stackoverflow.com/a/55883159).

The plugin provides you with a way to disable the auto signing in using [CredentialsClient.disableAutoSignIn](https://developers.google.com/android/reference/com/google/android/gms/auth/api/credentials/CredentialsClient#disableAutoSignIn()) and [GoogleSignIn.signOut](https://developers.google.com/android/reference/com/google/android/gms/auth/api/signin/GoogleSignInClient#signOut()).

## Usage

The following fragment illustrates the way to sign out the current user completely:

```dart
import 'package:android_disable_auto_sign_in/android_disable_auto_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

...

/// Sign out from Firebase normally
await FirebaseAuth.instance.signOut();
/// And, this will remove Google Smart Lock credential cache
await AndroidDisableAutoSignIn.smartLockSignOut();
```

## How to run the example code

To make the example work on your environment, you should do the following steps:

- Update `applicationId` on `example/android/app/build.gradle` to your own application ID:

```gradle
android {
    ...

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "jp.espresso3389.android_disable_auto_sign_in_example"
        ...
```

-  Place your own `google-services.json` on `example/android/app/`; see [Add Firebase using the Firebase console](https://firebase.google.com/docs/android/setup#console) to obtain your own one.
