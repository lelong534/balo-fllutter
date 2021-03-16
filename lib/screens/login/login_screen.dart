import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:zalo/screens/home.dart';

class Login extends StatefulWidget {
  static String routeName = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phoneNumber;
  String password;

  Dio dio = new Dio();

  Future login() async {
    final String url = 'https://bk-zalo.herokuapp.com/api/login';

    dynamic data = {
      'phone_number': phoneNumber,
      'password': password,
    };
    var response = await dio.post(url, data: data);

    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await login().then((value) => print(value));
          Navigator.pushNamed(context, Message.routeName);
        },
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
            child: Column(
              children: <Widget>[
                TextFormField(
                  style: TextStyle(
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Số điện thoại',
                  ),
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  style: TextStyle(
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
