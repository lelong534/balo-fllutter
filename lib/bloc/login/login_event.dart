// part of 'login_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String phonenumber;
  final String password;

  const LoginButtonPressed({
    @required this.phonenumber,
    @required this.password,
  });

  @override
  List<Object> get props => [phonenumber, password];

  @override
  String toString() =>
      'LoginButtonPressed { phonenumber: $phonenumber, password: $password }';
}
