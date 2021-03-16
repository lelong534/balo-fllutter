import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {},
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Text('Result'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          // actions: <Widget>[
          //   IconButton(
          //     onPressed: () {
          //       showSearch(context: context, delegate: Search());
          //     },
          //     icon: Icon(Icons.search),
          //   )
          // ],
          automaticallyImplyLeading: false,
          title: Row(
            children: <Widget>[
              Icon(Icons.search),
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
            ],
          ),
        ),
      ),
    );
  }
}
