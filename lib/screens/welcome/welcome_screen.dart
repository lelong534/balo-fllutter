import 'package:flutter/material.dart';

import 'components/body.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key key}) : super(key: key);

  static String routeName = 'welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
