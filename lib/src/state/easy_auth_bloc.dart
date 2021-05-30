import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_auth/easy_auth.dart';
import 'package:easy_auth/src/models/auth_events.dart';
import 'package:easy_auth/src/models/auth_state.dart';
import 'package:easy_auth/src/repositories/abstract_auth.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

class EasyAuthBloc<T extends EquatableUser> extends Bloc<AppEvent, AppState> {
  EasyAuthBloc({required AuthenticationRepository<T> authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const AppState.uninitialized()) {
    _userSubscription = _authenticationRepository.user.listen(_onUserChanged);
  }

  final AuthenticationRepository<T> _authenticationRepository;
  late final StreamSubscription<T> _userSubscription;

  AuthenticationRepository<T> get repository => _authenticationRepository;

  void _onUserChanged(T user) => add(AppUserChanged(user));

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppUserChanged) {
      if (event.user.isNotEmpty) {
        if (_authenticationRepository.isUserNew(event.user as T)) {
          yield AppState.newAccount(event.user);
        } else {
          yield AppState.authenticated(event.user);
        }
      } else {
        yield const AppState.unauthenticated();
      }
    } else if (event is AppLogInRequested) {
      yield const AppState.authenticating();
      final _action = _authenticationRepository.login(provider: event.provider);
      final _error = await _authenticationRepository.performSafeAuth(_action, AuthAction.login);
      if (_error != null) {
        yield AppState.unauthenticated(error: _error);
      }
    } else if (event is AppRegisterRequested<T>) {
      yield const AppState.authenticating();
      final _action = _authenticationRepository.register(user: event.user, password: event.password);
      final _error = await _authenticationRepository.performSafeAuth(_action, AuthAction.register);
      if (_error != null) {
        yield AppState.unauthenticated(error: _error);
      }
    } else if (event is AppSignOutRequested) {
      unawaited(_authenticationRepository.performSafeAuth(_authenticationRepository.signOut(), AuthAction.signOut));
    } else if (event is AppUserGraduate) {
      yield AppState.authenticated(_authenticationRepository.currentUser);
    } else if (event is AppUserDelete) {
      yield const AppState.unauthenticated();
      final _action = _authenticationRepository.deleteAccount();
      final _error = await _authenticationRepository.performSafeAuth(_action, AuthAction.deleteAccount);
      if (_error != null) {
        yield AppState.unauthenticated(error: _error);
        if (_authenticationRepository.currentUser != EquatableUser.empty) {
          unawaited(_authenticationRepository.performSafeAuth(_authenticationRepository.signOut(), AuthAction.signOut));
        }
      }
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
