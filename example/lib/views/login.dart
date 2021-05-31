import 'package:easy_auth/easy_auth.dart';
import 'package:example/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Scaffold-based view that showcases how your widgets can listen
/// to authentication state events
class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final user = UserData('1-1-1970', DateTime.now(), 'test@easyauth.com');
                EasyAuth.register<UserData>(context, user: user, password: '123456');
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
              child: EasyAuthBuilder<UserData>(builder: (context, status) {
                if (status == AuthStatus.authenticating) {
                  return const CupertinoActivityIndicator();
                }
                return const Text('Register valid user');
              }),
            ),
            ElevatedButton(
              onPressed: () =>
                  EasyAuth.login<UserData>(context, provider: const EmailPasswordAuth('test@easyauth.com', '123456')),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
              child: EasyAuthBuilder<UserData>(builder: (context, status) {
                if (status == AuthStatus.authenticating) {
                  return const CupertinoActivityIndicator();
                }
                return const Text('Perform valid login');
              }),
            ),
            ElevatedButton(
              onPressed: () => EasyAuth.login<UserData>(context,
                  provider: const EmailPasswordAuth('not-test@easyauth.com', 'notarealpassword')),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: EasyAuthBuilder<UserData>(builder: (context, status) {
                if (status == AuthStatus.authenticating) {
                  return const CupertinoActivityIndicator();
                }
                return const Text('Perform invalid login');
              }),
            ),
          ],
        ),
      ),
    );
  }
}
