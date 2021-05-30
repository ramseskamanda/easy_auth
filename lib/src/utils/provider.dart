import 'package:equatable/equatable.dart';

abstract class EasyAuthProvider extends Equatable {
  const EasyAuthProvider();

  @override
  List<Object?> get props => [];
}

class EmailPasswordAuth extends EasyAuthProvider {
  const EmailPasswordAuth(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class GoogleAuth extends EasyAuthProvider {}
