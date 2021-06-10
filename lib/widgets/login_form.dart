import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:zalo/bloc/login/login.dart';
import 'package:zalo/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zalo/screens/signup.dart';
import 'package:form_field_validator/form_field_validator.dart';

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
  bool isHidePassword = true;

  final _formKey = GlobalKey<FormState>();

  final phoneValidator = MultiValidator([
    RequiredValidator(errorText: "Bạn quên nhập ô này"),
    MinLengthValidator(10, errorText: 'Điện thoại dài ít nhất 10 kí tự'),
    MaxLengthValidator(10, errorText: 'Điện thoại dài nhiều nhất 10 kí tự'),
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Bạn quên nhập ô này'),
    MinLengthValidator(8, errorText: 'Mật khẩu dài ít nhất 8 kí tự'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Cần nhập thêm kí tự đặc biệt')
  ]);

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      if (_formKey.currentState.validate()) {
        BlocProvider.of<LoginBloc>(context).add(
          LoginButtonPressed(
            phonenumber: _phonenumberController.text,
            password: _passwordController.text,
          ),
        );
      }
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
        } else if (state is LoginFailure) {
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
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      child: Text("Lỗi, hãy đăng nhập lại"),
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
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
                  key: _formKey,
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
                        validator: phoneValidator,
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
                              icon: Icon(EvaIcons.eyeOutline),
                            ),
                          ),
                          validator: passwordValidator),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(
                          "Lưu ý: Số điện thoại là dãy số có 10 chữ số. Mật khẩu chứa ít nhất 8 kí tự, trong đó có ít nhất 1 kí tự đặc biệt",
                          style: TextStyle(
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    return Navigator.pushNamed(context, Signup.routeName);
                  },
                  child: Text(
                    "Chưa có tài khoản?",
                    textAlign: TextAlign.right,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
