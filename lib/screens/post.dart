import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zalo/bloc/get_post_bloc.dart';
import 'package:zalo/models/user.dart';
import 'package:zalo/models/user_response.dart';
import 'package:zalo/widgets/search.dart';
import 'package:zalo/bloc/get_user_bloc.dart';
import 'post/add.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  int index = 0;
  @override
  void initState() {
    super.initState();
    userBloc..getUser();
    postBloc..getListPosts(index);
  }

  buildPostAddition(User data) {
    User user = data;
    return Container(
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
          ),
          Padding(
            padding: EdgeInsets.only(top: 14),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar),
                ),
              ],
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildPostLoading() {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 25.0,
              width: 25.0,
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                strokeWidth: 4.0,
              ),
            )
          ],
        ),
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserResponse>(
      stream: userBloc.subject.stream,
      builder: (context, AsyncSnapshot<UserResponse> snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data.user;
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
            body:
                // SingleChildScrollView(
                //   physics: AlwaysScrollableScrollPhysics(),
                //   child:
                // Column(

                //   children: <Widget>[
                //     buildPostAddition(user),
                //     SizedBox(height: 8),
                //     buildPostItem(),
                //     SizedBox(height: 8),
                //     buildPostItem(),
                //     SizedBox(height: 8),
                //     buildPostItem(),
                //   ],
                // ),
                ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    buildPostAddition(user),
                    SizedBox(height: 8),
                    buildPostItem(),
                    SizedBox(height: 8),
                    buildPostItem(),
                    SizedBox(height: 8),
                    buildPostItem(),
                  ],
                );
              },
              itemCount: 20,
            ),
            // ),
          );
        }
        return _buildPostLoading();
      },
    );
  }
}
