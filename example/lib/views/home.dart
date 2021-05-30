import 'package:easy_auth/easy_auth.dart';
import 'package:flutter/material.dart';

/// Scaffold-based widget that is shown when a user is considered authenticated
class HomeView extends StatelessWidget {
  const HomeView({Key? key})
      : newAccount = false,
        super(key: key);
  const HomeView.newAccount({Key? key})
      : newAccount = true,
        super(key: key);

  final bool newAccount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Congratulations, you\'re logged in!'),
            Text('Your email: ${EasyAuth.currentUser(context).email}'),
            if (newAccount)
              ElevatedButton(
                onPressed: () => EasyAuth.graduateUser(context),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                child: const Text('Graduate user from new account'),
              ),
            ElevatedButton(
              onPressed: () => EasyAuth.signOut(context),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: const Text('Sign out'),
            ),
            ElevatedButton(
              onPressed: () => EasyAuth.deleteAccount(context),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: const Text('Delete account'),
            ),
          ],
        ),
      ),
    );
  }
}
