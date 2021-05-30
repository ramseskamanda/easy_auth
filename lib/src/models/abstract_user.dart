import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

//TODO: consider making this class `abstract`

/// {@template user}
/// User model
///
/// {@endtemplate}
class EquatableUser extends Equatable {
  /// {@macro user}
  @mustCallSuper
  const EquatableUser({required this.id, this.createdAt, this.email, this.name});

  /// {@macro user}
  const EquatableUser.register({this.email, this.name, this.createdAt}) : id = '';

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's name
  final String? name;

  /// The current user's creation time
  final DateTime? createdAt;

  /// Empty user which represents an unauthenticated user.
  static const empty = EquatableUser(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == EquatableUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != EquatableUser.empty;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [email, id, name];
}
