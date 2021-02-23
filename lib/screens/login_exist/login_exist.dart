import 'package:flutter/material.dart';

import 'components/body.dart';

class LoginExist extends StatefulWidget {
  static String routeName = 'login-exist';
  @override
  _LoginExistState createState() => _LoginExistState();
}

class _LoginExistState extends State<LoginExist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo tài khoản'),
      ),
      body: Body(),
    );
  }
}
