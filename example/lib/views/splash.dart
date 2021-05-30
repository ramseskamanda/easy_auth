import 'package:flutter/material.dart';

/// Scaffold-based view to showcase how to take over from the native splash screen
/// whilst waiting for the app to finish initializing and authenticating the user
class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
