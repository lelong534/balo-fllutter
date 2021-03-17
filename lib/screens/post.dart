import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zalo/widgets/search.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  buildPostHeader() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage('https://bom.to/Yyc4NobeUpY2'),
      ),
      title: GestureDetector(
        onTap: () => print('showing profile'),
        child: Text(
          'Long Le',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      subtitle: Text('3 giờ trước'),
    );
  }

  buildPostItem() {
    return Column(
      children: <Widget>[
        buildPostHeader(),
        buildPostContent(),
        buildPostImage(),
        buildPostFooter(),
        Container(
          color: Colors.grey[300],
          height: 8,
        )
      ],
    );
  }

  buildPostContent() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Cô gái người dân tộc',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        SizedBox(height: 20)
      ],
    );
  }

  buildPostImage() {
    return GestureDetector(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.network('https://bom.to/0Ne4CwVWQdDF'),
        ],
      ),
    );
  }

  buildPostFooter() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 40.0, left: 20.0)),
            GestureDetector(
              onTap: () => print('liking post'),
              child: Icon(
                Icons.favorite,
                size: 28.0,
                color: Colors.pink,
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 5.0)),
            Text('12'),
            Padding(padding: EdgeInsets.only(right: 20.0)),
            GestureDetector(
              onTap: () => print('showing comments'),
              child: Icon(
                Icons.chat_outlined,
                size: 28.0,
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 5.0)),
            Text('2'),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.blue, Colors.blue[100]],
            ),
          ),
        ),
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
      body: ListView(
        children: <Widget>[
          buildPostItem(),
          buildPostItem(),
          buildPostItem(),
        ],
      ),
    );
  }
}
