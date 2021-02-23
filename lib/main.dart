import 'package:flutter/material.dart';

import 'routes.dart';
import 'screens/welcome/welcome_screen.dart';
import 'screens/login_exist/login_exist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginExist.routeName,
      routes: routes,
    );
  }
}
