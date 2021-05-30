import 'package:easy_auth/easy_auth.dart';
import 'package:easy_auth/src/models/auth_events.dart';
import 'package:easy_auth/src/state/easy_auth_bloc.dart';
import 'package:easy_auth/src/utils/provider.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_bloc/flutter_bloc.dart';

///The entry point of the EasyAuth SDK.
class EasyAuth {
  /// Obtain a value from the nearest ancestor provider of type [EasyAuthBloc].
  ///
  /// Behaves very similarily to `Navigator.of` from the material.dart library
  /// or `context.read<T>` from the bloc library
  static EasyAuthBloc of(BuildContext context) => context.read<EasyAuthBloc>();

  /// Sends SignOut request to the `EasyAuthBloc` for the current user.
  static void signOut(BuildContext context) => EasyAuth.of(context).add(AppSignOutRequested());

  /// Sends Login request to the `EasyAuthBloc` for the current user.
  static void login(BuildContext context, {required EasyAuthProvider provider}) =>
      EasyAuth.of(context).add(AppLogInRequested(provider: provider));

  /// Sends Register request to the `EasyAuthBloc` for the current user.
  static void register<T extends EquatableUser>(BuildContext context, {required T user, required String password}) =>
      EasyAuth.of(context).add(AppRegisterRequested(user: user, password: password));

  /// Sends Graduation request to the `EasyAuthBloc` for the current user.
  ///
  /// This means the user will not be considered a 'new' user anymore.
  static void graduateUser(BuildContext context) => EasyAuth.of(context).add(AppUserGraduate());

  /// Sends AuthDeleteAccount request to the `EasyAuthBloc` for the current user.
  ///
  /// ⚠️ This action deletes a user!
  static void deleteAccount(BuildContext context) => EasyAuth.of(context).add(AppUserDelete());

  /// Returns the current user from the AuthenticationRepository
  static T currentUser<T extends EquatableUser>(BuildContext context) =>
      EasyAuth.of(context).repository.currentUser as T;
}
