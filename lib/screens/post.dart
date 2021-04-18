import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:eva_icons_flutter/icon_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zalo/widgets/search.dart';
import 'post/add.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  buildPostHeader() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
            'https://i1-thethao.vnecdn.net/2021/04/01/Ozil-4900-1617262425.jpg?w=0&h=0&q=100&dpr=1&fit=crop&s=pIa-_3sUfz015cW-Jhs5EA'),
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
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          buildPostHeader(),
          buildPostContent(),
          buildPostImage(),
          buildPostFooter(),
        ],
      ),
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
              'Chào buổi sáng',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }

  buildPostImage() {
    return GestureDetector(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.network(
              'https://i1-thethao.vnecdn.net/2021/04/01/Ozil-4900-1617262425.jpg?w=0&h=0&q=100&dpr=1&fit=crop&s=pIa-_3sUfz015cW-Jhs5EA')
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
            Padding(padding: EdgeInsets.only(top: 60.0, left: 20.0)),
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
      backgroundColor: Colors.grey[300],
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            buildPostAddition(),
            SizedBox(height: 8),
            buildPostItem(),
            SizedBox(height: 8),
            buildPostItem(),
            SizedBox(height: 8),
            buildPostItem(),
          ],
        ),
      ),
    );
  }

  buildPostAddition() {
    return Container(
      height: 60,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://i1-thethao.vnecdn.net/2021/04/01/Ozil-4900-1617262425.jpg?w=0&h=0&q=100&dpr=1&fit=crop&s=pIa-_3sUfz015cW-Jhs5EA'),
          ),
          SizedBox(width: 14),
          Expanded(
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Hôm nay bạn thế nào?",
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                ),
                border: InputBorder.none,
              ),
              onTap: () {
                Navigator.pushNamed(context, AddPost.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
