import 'package:easy_auth/src/repositories/abstract_auth.dart';

class AuthException implements Exception {
  const AuthException(this.message, this.action);

  final String message;
  final AuthAction action;
}
