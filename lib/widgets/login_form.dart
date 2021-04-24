import 'package:zalo/bloc/login/login.dart';
import 'package:zalo/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepository;
  LoginForm({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState(userRepository);
}

class _LoginFormState extends State<LoginForm> {
  final UserRepository userRepository;
  _LoginFormState(this.userRepository);
  final _phonenumberController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          phonenumber: _phonenumberController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return Scaffold(
            body: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.blue),
                      strokeWidth: 4.0,
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Đăng nhập'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _onLoginButtonPressed,
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.east,
              color: Colors.white,
            ),
          ),
          body: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Text(
                  'Vui lòng nhập số điện thoại và mật khẩu',
                  style: TextStyle(fontSize: 13),
                ),
                color: Colors.black12,
                padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _phonenumberController,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Số điện thoại',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
