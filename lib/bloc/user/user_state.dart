import 'package:equatable/equatable.dart';
import 'package:zalo/models/user_response.dart';

abstract class UserState extends Equatable {}

class UserInitial extends UserState {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => 'User initial';
}

class UserChanging extends UserState {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => 'User changing';
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => 'User loading';
}

class UserUpdated extends UserState {
  final UserResponse user;

  @override
  List<Object> get props => [user];

  UserUpdated(this.user);

  @override
  String toString() => 'User updated';
}

class UserFailure extends UserState {
  final String error;

  UserFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UserFailure { error: $error }';
}
