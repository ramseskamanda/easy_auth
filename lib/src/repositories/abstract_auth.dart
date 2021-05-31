import 'package:easy_auth/easy_auth.dart';
import 'package:easy_auth/src/utils/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

enum AuthAction {
  login,
  register,
  signOut,
  deleteAccount,
}

///AuthenticationRepository needs to be extended and passed into AuthApp
///
///It is vividly recommended to extend this class as a Singleton
///as this would allow for access patterns like the following:
///
///```dart
///final String uid = MyExtendedAuthenticationRepository.instance.currentUser.id
///```
///
///Caching should also be taken care of in the repository
abstract class AuthenticationRepository<T extends EquatableUser> {
  Future<void> login({required EasyAuthProvider provider});
  Future<void> register({required T user, required String password});
  Future<void> signOut();
  Future<void> deleteAccount();

  bool isUserNew(T user);

  /// Only override if you know what you're doing and want custom error handling
  /// or the error handling here does not fit your use case
  Future<AuthException?> performSafeAuth(Future<void> future, AuthAction action) async {
    try {
      await future;
    } on FirebaseAuthException catch (e) {
      return AuthException(e.code, action);
    } on PlatformException catch (e) {
      return AuthException(e.code, action);
    } catch (err) {
      return AuthException(err.toString(), action);
    }
  }

  /// Stream of [T] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [EquatableUser.empty] if the user is not authenticated.
  Stream<T> get user;
}
