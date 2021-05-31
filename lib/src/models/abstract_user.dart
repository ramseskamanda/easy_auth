import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// {@template user}
/// User model
///
/// {@endtemplate}
abstract class EquatableUser extends Equatable {
  /// {@macro user}
  @mustCallSuper
  const EquatableUser({required this.id, required this.createdAt, this.email, this.username});

  /// The current user's creation time
  final DateTime createdAt;

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's username
  final String? username;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [email, id, username];
}
