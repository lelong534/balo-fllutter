import 'package:flutter/material.dart';

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
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Số điện thoại',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Nhập lại mật khẩu',
                    ),
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
