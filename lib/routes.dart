import 'package:flutter/widgets.dart';
import 'screens/welcome/welcome_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/login_exist/login_exist.dart';
import 'screens/home.dart';
import 'screens/post/add.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  Welcome.routeName: (context) => Welcome(),
  Signup.routeName: (context) => Signup(),
  Login.routeName: (context) => Login(),
  LoginExist.routeName: (context) => LoginExist(),
  Message.routeName: (context) => Message(),
  AddPost.routeName: (context) => AddPost(),
};
