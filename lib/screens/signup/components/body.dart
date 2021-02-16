import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
    );
  }
}
