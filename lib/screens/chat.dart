import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zalo/widgets/search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.blue, Colors.blue[300]],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            Icon(EvaIcons.searchOutline),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Tìm kiếm bạn bè, tin nhắn ...",
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                  ),
                  border: InputBorder.none,
                ),
                onTap: () {
                  showSearch(context: context, delegate: Search());
                },
              ),
            ),
            Icon(FontAwesomeIcons.qrcode),
            SizedBox(
              width: 10,
            ),
            Icon(EvaIcons.plusOutline),

          ],
        ),
      ),
    );
  }
}
