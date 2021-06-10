import 'package:equatable/equatable.dart';
import 'package:zalo/models/user_response.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUnitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final UserResponse user;
  AuthenticationAuthenticated(this.user);
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
