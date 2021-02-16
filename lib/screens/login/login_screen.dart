import 'package:flutter/material.dart';

import 'components/body.dart';

class Login extends StatefulWidget {
  static String routeName = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập'),
      ),
      floatingActionButton: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Icon(
          Icons.east,
          color: Colors.white,
        ),
      ),
      body: Body(),
    );
  }
}
