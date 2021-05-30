<p align="center" style="text-align: center; font-size: 4rem; font-weight: bold;">
<!-- <img src="https://raw.githubusercontent.com/felangel/bloc/master/docs/assets/flutter_bloc_logo_full.png" height="100" alt="Flutter Bloc Package" /> -->
EasyAuth
</p>

<p align="center">
<a href="https://pub.dev/packages/very_good_analysis"><img src="https://img.shields.io/badge/style-very_good_analysis-B22C89.svg" alt="very good analysis"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
</p>

---

Widgets and classes that make it easy to add authentication to any [Flutter](https://flutter.dev) app. Built on top of the [package:bloc](https://pub.dev/packages/bloc) architecture, it is fully authentication framework agnostic but provides some plug-and-play mechanisms for commonly used frameworks like [package:firebase_auth](https://pub.dev/packages/firebase_auth).

⚠️ If you like this repository, I would really appreciate some help in maintaining/improving/promoting it! I'm also listening to logo ideas

---

## Usage

Lets take a look at how to integrate a basic Firebase Auth state to your app. For other examples, check the [examples](https://github.com/ramseskamanda/easy_auth/tree/master/example) folder

First, we create a basic MaterialApp (or any other app you might use) and initialize the default Firebase App.

```dart
// -> main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance!.resamplingEnabled = true;
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyApp(),
    ),
  );
}
```

We then create our `MyApp` widget that extends `AuthenticationBasedApp`.

```dart
// -> myapp.dart
class MyApp extends AuthenticationBasedApp<EquatableUser> {
  const MyApp({Key? key}) : super(key: key);

  @override
  BasicFirebaseAuth get repository => BasicFirebaseAuth();

  @override
  Widget buildState(BuildContext context, AuthStatus status, EquatableUser user) {
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
```

That's it, you're done! Now you can use the package as you would use `FirebaseAuth` and login, signout, create accounts, etc.

Notice that we passed the `EquatableUser` class as a generic to `AuthenticationBasedApp`, let's talk about why.

### EquatableUser

This class is used as a default representation of what a user would be. It can easily be extended to add your own parameters.

As it extends Equatable, if you want to include property as part of the == operation, you'll have to add it to the props array.

```dart
// -> custom_user.dart
class CustomUser extends EquatableUser {
 const CustomUser({required this.birthday}) : super(id: '1', email: 'first@user.com');

 final String birthday;

 @override
 List<Object?> get props => [...super.props, birthday];
}
```

### EasyAuth methods

**EasyAuth** is a utility class that lets you statically access the methods on your `AuthenticationRepository`.

```dart
ElevatedButton(
  child: const Text('Log in'),
  onPressed: () {
    final provider = EmailPasswordAuth('test@easyauth.com', 'some-password');
    EasyAuth.login(context, provider: provider);
  },
)
```

### AuthenticationRepository

**AuthenticationRepository** is an abstract class that defines all the methods necessary to add a custom authentication provider.

**Note that you do not need to handle errors when overriding any methods in this class!**

```dart
abstract class AuthenticationRepository<T extends EquatableUser> {
  Future<void> login({required EasyAuthProvider provider});
  Future<void> register({required T user, required String password});
  Future<void> signOut();
  Future<void> deleteAccount();
  bool isUserNew(T user);

  T get currentUser;
  Stream<T> get user;

  Future<AuthException?> performSafeAuth(Future<void> future, AuthAction action) async {...}
}
```

The only method that does **not** need to be re-implemented is `performSafeAuth(...)`. It is used to handle any errors that might be thrown by performing an authentication action.

### EasyAuth Widgets

#### AuthenticationBasedApp

#### EasyAuthBuilder

**EasyAuthBuilder** is a Flutter widget which requires a `builder` function. `EasyAuthBuilder` handles building the widget in response to new authentication states. `EasyAuthBuilder` is a simple wrapper around `BlocBuilder` from [package:bloc](https://pub.dev/packages/bloc). The `builder` function will potentially be called many times and should be a [pure function](https://en.wikipedia.org/wiki/Pure_function) that returns a widget in response to the state.

```dart
EasyAuthBuilder(
  builder: (context, status, user) {
    // return widget here based on the current AuthSatus and User
  }
)
```

<!-- ## Gallery

<div style="text-align: center">
  <table>
    <tr>
      <td style="text-align: center">
        <a href="https://bloclibrary.dev/#/fluttercountertutorial">
          <img src="https://bloclibrary.dev/assets/gifs/flutter_counter.gif" width="200" />
        </a>
      </td>
    </tr>
  </table>
</div> -->

## Examples

- [Basic Valid/Invalid Authentication](https://github.com/ramseskamanda/easy_auth/tree/master/example) - an example of how to create a basic authentication system in any Flutter app.

## Dart Versions

- Dart 2: >= 2.12
- Flutter: >=1.17.0

## Maintainers

- [Ramses Kamanda](https://github.com/ramseskamanda)
