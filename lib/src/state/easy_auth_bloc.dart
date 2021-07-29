import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_auth/easy_auth.dart';
import 'package:easy_auth/src/models/auth_events.dart';
import 'package:easy_auth/src/models/auth_state.dart';
import 'package:easy_auth/src/repositories/abstract_auth.dart';

class EasyAuthBloc<T extends EquatableUser>
    extends Bloc<AppEvent, AppState<T>> {
  EasyAuthBloc({required AuthenticationRepository<T> authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(AppState<T>.uninitialized()) {
    _stream = _authenticationRepository.user.shareValue();
    _userSubscription = _stream.listen((u) => add(AppUserChanged<T>(u)));
  }

  final AuthenticationRepository<T> _authenticationRepository;

  late final ValueStream<T?> _stream;
  late final StreamSubscription<T?> _userSubscription;

  AuthenticationRepository<T> get repository => _authenticationRepository;

  /// Returns the current cached user.
  /// Defaults to `null` if there is no cached user.
  T? get currentUser {
    try {
      return _stream.value;
    } on ValueStreamError {
      return null;
    }
  }

  @override
  Stream<AppState<T>> mapEventToState(AppEvent event) async* {
    if (event is AppUserChanged<T>) {
      if (event.user != null) {
        if (_authenticationRepository.isUserNew(event.user!)) {
          yield AppState.newAccount(event.user!);
        } else {
          yield AppState.authenticated(event.user!);
        }
      } else {
        yield AppState<T>.unauthenticated();
      }
    } else if (event is AppLogInRequested) {
      yield AppState<T>.authenticating();
      final _action = _authenticationRepository.login(provider: event.provider);
      final _error = await _authenticationRepository.performSafeAuth(
          _action, AuthAction.login);
      if (_error != null) {
        yield AppState.unauthenticated(error: _error);
      }
    } else if (event is AppRegisterRequested<T>) {
      yield AppState<T>.authenticating();
      final _action = _authenticationRepository.register(
          user: event.user, password: event.password);
      final _error = await _authenticationRepository.performSafeAuth(
          _action, AuthAction.register);
      if (_error != null) {
        yield AppState.unauthenticated(error: _error);
      }
    } else if (event is AppSignOutRequested) {
      await _authenticationRepository.performSafeAuth(
          _authenticationRepository.signOut(), AuthAction.signOut);
    } else if (event is AppUserGraduate) {
      yield AppState.authenticated(currentUser!);
    } else if (event is AppUserDelete) {
      yield AppState<T>.unauthenticated();
      final _action = _authenticationRepository.deleteAccount();
      final _error = await _authenticationRepository.performSafeAuth(
          _action, AuthAction.deleteAccount);
      if (_error != null) {
        yield AppState.unauthenticated(error: _error);
        if (currentUser != null) {
          await _authenticationRepository.performSafeAuth(
              _authenticationRepository.signOut(), AuthAction.signOut);
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
