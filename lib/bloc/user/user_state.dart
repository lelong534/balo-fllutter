import 'package:equatable/equatable.dart';
import 'package:zalo/models/user_response.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {
  @override
  String toString() => 'User initial';
}

class UserChanging extends UserState {
  @override
  String toString() => 'User changing';
}

class UserLoading extends UserState {
  @override
  String toString() => 'User loading';
}

class UserUpdated extends UserState {
  final UserResponse user;
  UserUpdated(this.user);

  @override
  String toString() => 'User updated';
}

class UserFailure extends UserState {
  final String error;

  const UserFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UserFailure { error: $error }';
}
