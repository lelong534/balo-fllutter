import 'package:flutter/widgets.dart';
import 'screens/signup.dart';
import 'screens/login.dart';
import 'screens/login_exist/login_exist.dart';
import 'screens/home.dart';
import 'screens/post/add.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  Signup.routeName: (context) => Signup(),
  LoginExist.routeName: (context) => LoginExist(),
  Message.routeName: (context) => Message(),
  AddPost.routeName: (context) => AddPost(),
};
