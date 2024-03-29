import 'package:easy_auth/easy_auth.dart';
import 'package:easy_auth/src/models/auth_state.dart';
import 'package:easy_auth/src/state/easy_auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The root of this package
abstract class AuthenticationBasedApp<T extends EquatableUser>
    extends StatelessWidget {
  /// The root of this package
  const AuthenticationBasedApp({Key? key}) : super(key: key);

  /// Getter for the custom subclass of AuthenticationRepository with your authentication logic
  AuthenticationRepository<T> get repository;

  /// Rebuilds the state of the app every time the authentication status changes.
  /// This is an efficient method due to `T` extending `Equatable` and
  /// therefore only rebuilding when necessary
  Widget buildState(BuildContext context, AuthStatus status, T? user);

  /// Called when an exception relating to authentication gets thrown.
  /// Can be overriden to provide your own custom logic (e.g. logging, custome snackbar, etc.)
  void handleError(BuildContext context, AuthException exception) {
    // ignore: avoid_print
    print(
        'Tried performing ${exception.action} and received an exception: $exception');
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = EasyAuthBloc<T>(authenticationRepository: repository);
    return BlocProvider.value(
      value: _bloc,
      child: BlocConsumer<EasyAuthBloc<T>, AppState<T>>(
        bloc: _bloc,
        listener: (context, state) {
          if (state.hasError) {
            handleError(context, state.error!);
          }
        },
        builder: (context, state) =>
            buildState(context, state.status, state.user),
      ),
    );
  }
}
