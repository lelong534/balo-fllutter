import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shadowColor: Colors.white12,
            ),
            onPressed: () {
              print("tap");
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blue,
                    child: Icon(EvaIcons.peopleOutline, color: Colors.white),
                  ),
                  SizedBox(width: 20),
                  Text("Lời mời kết bạn",
                      style: TextStyle(color: Colors.black, fontSize: 16))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
