import 'package:flutter/material.dart';

class ExistContent extends StatelessWidget {
  const ExistContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Đã tồn tại 1 tài khoản Balo được gắn với số điện thoại 0123456789',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Spacer(),
        SizedBox(
          width: 60,
          height: 60,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/avatar.png'),
          ),
        ),
        Spacer(),
        Text('Lê Long'),
        Spacer(),
        Text('(+84) 34 725 4159'),
        Spacer(),
        Text('Nếu Lê Long là tài khoản của bạn'),
        Text('Đăng nhập tại đây'),
      ],
    );
  }
}
