import 'package:easy_auth/src/models/abstract_user.dart';
import 'package:easy_auth/src/utils/provider.dart';
import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppSignOutRequested extends AppEvent {}

class AppUserChanged<T extends EquatableUser> extends AppEvent {
  const AppUserChanged(this.user);

  final T user;

  @override
  List<Object> get props => [user];
}

class AppLogInRequested extends AppEvent {
  const AppLogInRequested({required this.provider});

  final EasyAuthProvider provider;
}

class AppRegisterRequested<T extends EquatableUser> extends AppEvent {
  const AppRegisterRequested({required this.user, required this.password});

  final T user;
  final String password;
}

class AppUserGraduate extends AppEvent {}

class AppUserDelete extends AppEvent {}
