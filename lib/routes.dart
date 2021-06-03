import 'package:flutter/widgets.dart';
import 'package:zalo/screens/contact.dart';
import 'package:zalo/screens/friend_suggest.dart';
import 'screens/signup.dart';
import 'screens/login_exist/login_exist.dart';
import 'screens/home.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  Signup.routeName: (context) => Signup(),
  LoginExist.routeName: (context) => LoginExist(),
  Message.routeName: (context) => Message(),
  Contact.routeName: (context) => Contact(),
  FriendSuggestScreen.routeName: (context) => FriendSuggestScreen(),
};
