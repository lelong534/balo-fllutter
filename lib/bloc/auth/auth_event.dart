import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final List userInfo;

  const LoggedIn({@required this.userInfo});

  @override
  List<Object> get props => [userInfo];

  @override
  String toString() => 'LoggedIn { token: $userInfo }';
}

class LoggedOut extends AuthenticationEvent {}
