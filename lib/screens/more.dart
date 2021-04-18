import 'package:flutter/material.dart';
import 'package:zalo/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zalo/bloc/auth/auth.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Text("Đăng xuất"),
        onPressed: () {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
        },
      ),
    );
  }
}
