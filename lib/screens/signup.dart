import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zalo/bloc/user_bloc.dart';
import 'package:alert/alert.dart';

class Signup extends StatefulWidget {
  static String routeName = 'signup';
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isHidePassword = true;
  final _phonenumberController = TextEditingController();
  final _againPhonenumberController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onSignupButtonPressed() {
    userBloc..signUp(_phonenumberController.text, _passwordController.text);
    Alert(message: 'Đăng kí thành công').show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng ký'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onSignupButtonPressed,
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.east,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Text(
                'Vui lòng điền thông tin đăng ký của bạn',
                style: TextStyle(fontSize: 13),
              ),
              color: Colors.black12,
              padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
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
                    obscureText: isHidePassword,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                        labelText: 'Mật khẩu',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isHidePassword = !isHidePassword;
                            });
                          },
                          icon: isHidePassword
                              ? Icon(EvaIcons.eyeOutline)
                              : Icon(EvaIcons.eyeOffOutline),
                        )),
                  ),
                  TextFormField(
                    controller: _againPhonenumberController,
                    obscureText: isHidePassword,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                        labelText: 'Nhập lại mật khẩu',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isHidePassword = !isHidePassword;
                            });
                          },
                          icon: isHidePassword
                              ? Icon(EvaIcons.eyeOutline)
                              : Icon(EvaIcons.eyeOffOutline),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
