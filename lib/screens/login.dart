import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zalo/bloc/auth/auth.dart';
import 'package:zalo/bloc/login/login.dart';
import 'package:zalo/repositories/user_repository.dart';
import 'package:zalo/widgets/login_form.dart';

class Login extends StatefulWidget {
  final UserRepository userRepository;
  Login({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  _LoginState createState() => _LoginState(userRepository);
}

class _LoginState extends State<Login> {
  final UserRepository userRepository;
  _LoginState(this.userRepository);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginBloc(
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          userRepository: userRepository,
        );
      },
      child: LoginForm(userRepository: userRepository),
    );
  }
}
