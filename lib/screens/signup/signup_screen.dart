import 'package:flutter/material.dart';

import 'components/body.dart';

class Signup extends StatefulWidget {
  static String routeName = 'signup';
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng ký'),
      ),
      body: Body(),
    );
  }
}
