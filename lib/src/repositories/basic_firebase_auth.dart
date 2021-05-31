import 'package:easy_auth/easy_auth.dart';
import 'package:easy_auth/src/utils/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BasicFirebaseAuth<T extends EquatableUser>
    extends AuthenticationRepository<T> {
  BasicFirebaseAuth({required this.transformer});

  final _firebaseAuth = FirebaseAuth.instance;
  final T Function(User) transformer;

  @override
  Stream<T?> get user => _firebaseAuth.authStateChanges().map<T?>((user) {
        if (user == null) {
          return null;
        } else {
          return transformer(user);
        }
      });

  @override
  bool isUserNew(T user) => user.createdAt
      .isAfter(DateTime.now().subtract(const Duration(seconds: 5)));

  @override
  Future<void> login({required EasyAuthProvider provider}) async {
    if (provider is EmailPasswordAuth) {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: provider.email, password: provider.password);
    } else if (provider is GoogleAuth) {
      //sign in with google
    }
  }

  @override
  Future<void> register({required T user, required String password}) async {
    if (user.email == null)
      throw FirebaseAuthException(code: 'no-email-registration');
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email!, password: password);
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();

  @override
  Future<void> deleteAccount() => _firebaseAuth.currentUser!.delete();
}
