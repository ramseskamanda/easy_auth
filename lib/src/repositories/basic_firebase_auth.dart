import 'package:easy_auth/easy_auth.dart';
import 'package:easy_auth/src/utils/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BasicFirebaseAuth extends AuthenticationRepository<EquatableUser> {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<EquatableUser> get user => _firebaseAuth.authStateChanges().map<EquatableUser>((user) {
        if (user == null) {
          return EquatableUser.empty;
        } else {
          return EquatableUser(
            id: user.uid,
            name: user.displayName,
            email: user.email,
            createdAt: user.metadata.creationTime,
          );
        }
      });

  @override
  bool isUserNew(EquatableUser user) =>
      user.createdAt?.isAfter(DateTime.now().subtract(const Duration(seconds: 5))) ?? false;

  @override
  Future<void> login({required EasyAuthProvider provider}) async {
    if (provider is EmailPasswordAuth) {
      await _firebaseAuth.signInWithEmailAndPassword(email: provider.email, password: provider.password);
    } else if (provider is GoogleAuth) {
      //sign in with google
    }
  }

  @override
  Future<void> register({required EquatableUser user, required String password}) async {
    if (user.email == null) throw FirebaseAuthException(code: 'no-email-registration');
    await _firebaseAuth.createUserWithEmailAndPassword(email: user.email!, password: password);
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();

  @override
  Future<void> deleteAccount() => _firebaseAuth.currentUser!.delete();
}
