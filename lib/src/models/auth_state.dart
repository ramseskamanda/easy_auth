import 'package:easy_auth/easy_auth.dart';
import 'package:equatable/equatable.dart';

class AppState<T extends EquatableUser> extends Equatable {
  const AppState._({
    required this.status,
    required this.user,
    this.error,
  });

  const AppState.authenticated(T user) : this._(status: AuthStatus.authenticated, user: user);
  const AppState.newAccount(T user) : this._(status: AuthStatus.newAccount, user: user);
  const AppState.authenticating() : this._(status: AuthStatus.authenticating, user: EquatableUser.empty as T);
  const AppState.uninitialized() : this._(status: AuthStatus.uninitialized, user: EquatableUser.empty as T);
  const AppState.unauthenticated({AuthException? error})
      : this._(status: AuthStatus.unauthenticated, user: EquatableUser.empty as T, error: error);

  final AuthStatus status;
  final T user;
  final AuthException? error;

  bool get hasError => error != null;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [status, user, error];
}
