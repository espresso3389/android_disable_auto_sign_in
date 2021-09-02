import 'package:flutter/material.dart';

import 'package:android_disable_auto_sign_in/android_disable_auto_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_auth_ui/flutter_auth_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                child: const Text("start ui"),
                onPressed: () async {
                  final providers = [
                    AuthUiProvider.apple,
                    AuthUiProvider.google,
                    AuthUiProvider.microsoft,
                  ];

                  final result = await FlutterAuthUi.startUi(
                    items: providers,
                    tosAndPrivacyPolicy: TosAndPrivacyPolicy(
                      tosUrl: "https://www.google.com",
                      privacyPolicyUrl: "https://www.google.com",
                    ),
                  );
                  final user = FirebaseAuth.instance.currentUser;
                  if (user?.email != null) {
                    print('email: ${user!.email}');
                    print('verified: ${user.emailVerified}');
                    print('token: ${await user.getIdToken()}');
                    print(
                        'providers: ${user.providerData.fold<String>('', (v, ui) => v == '' ? ui.providerId : v + ',' + ui.providerId)}');
                    //await user.delete();
                  } else {
                    print('Auth UI failure.');
                  }
                  await FirebaseAuth.instance.signOut();
                  await AndroidDisableAutoSignIn.smartLockSignOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
