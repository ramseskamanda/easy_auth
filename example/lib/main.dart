import 'package:easy_auth/easy_auth.dart';
import 'package:example/basic_firebase_auth.dart';
import 'package:example/views/home.dart';
import 'package:example/views/login.dart';
import 'package:example/views/splash.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class UserData extends EquatableUser {
  const UserData(this.birthday, DateTime createdAt, String? email)
      : super(id: '1', email: email, createdAt: createdAt);

  final String birthday;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance!.resamplingEnabled = true;
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const _MyApp(),
    ),
  );
}

class _MyApp extends AuthenticationBasedApp<UserData> {
  const _MyApp({Key? key}) : super(key: key);

  @override
  BasicFirebaseAuth<UserData> get repository => BasicFirebaseAuth<UserData>(
      transformer: (user) =>
          UserData('1-1-1970', user.metadata.creationTime!, user.email));

  @override
  Widget buildState(BuildContext context, AuthStatus status, UserData? user) {
    switch (status) {
      case AuthStatus.uninitialized:
        return const SplashScreenView();
      case AuthStatus.authenticated:
        return const HomeView();
      case AuthStatus.newAccount:
        return const HomeView.newAccount();
      case AuthStatus.authenticating:
      case AuthStatus.unauthenticated:
        return const LoginView();
    }
  }
}
