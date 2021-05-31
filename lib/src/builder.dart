import 'package:easy_auth/easy_auth.dart';
import 'package:easy_auth/src/models/auth_state.dart';
import 'package:easy_auth/src/state/easy_auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EasyAuthBuilder<T extends EquatableUser> extends StatelessWidget {
  const EasyAuthBuilder({Key? key, required this.builder}) : super(key: key);

  final Widget Function(BuildContext, AuthStatus) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EasyAuthBloc<T>, AppState<T>>(
      builder: (context, state) => builder(context, state.status),
    );
  }
}
