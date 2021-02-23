import 'package:flutter/material.dart';

import 'exist_content.dart';
import 'bottom_button.dart';

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
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ExistContent(),
          ),
          Spacer(
            flex: 2,
          ),
          BottomButton(),
        ],
      ),
    );
  }
}
