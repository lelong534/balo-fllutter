import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zalo/bloc/get_post_bloc.dart';
import 'package:zalo/models/post.dart';
import 'package:zalo/models/post_response.dart';
import 'package:zalo/models/user.dart';
import 'package:zalo/models/user_response.dart';
import 'package:zalo/widgets/search.dart';
import 'package:zalo/bloc/get_user_bloc.dart';
import 'post/add.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
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

  buildPostHeader(Post postItem) {
    var avatarLink;
    if (postItem.authorAvatar == null) {
      avatarLink = "";
      return Container();
    } else {
      avatarLink = postItem.authorAvatar;
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(avatarLink),
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
  }

  buildPostContent(Post postItem) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              postItem.described,
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }

  buildPostImage(Post postItem) {
    var avatarLink;
    if (postItem.images.length == 0) {
      avatarLink = "";
      return Container();
    } else {
      avatarLink = postItem.images[0]["link"];
      return GestureDetector(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[Image.network(avatarLink, scale: 0.6)],
        ),
      );
    }
  }

  buildPostFooter(Post postItem) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 60.0, left: 20.0)),
            GestureDetector(
              onTap: () => postBloc..likePost(postItem.id),
              child: Icon(
                // Icons.favorite,
                EvaIcons.heartOutline,
                size: 28.0,
                // color: Colors.pink,
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 5.0)),
            Text(postItem.like.toString()),
            Padding(padding: EdgeInsets.only(right: 20.0)),
            GestureDetector(
              onTap: () => print('showing comments'),
              child: Icon(
                EvaIcons.messageCircleOutline,
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

  buildPostItem(Post postItem) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          buildPostHeader(postItem),
          buildPostContent(postItem),
          buildPostImage(postItem),
          buildPostFooter(postItem),
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
            body: Column(
              children: <Widget>[
                Expanded(child: buildPostAddition(user), flex: 1),
                SizedBox(height: 6),
                Expanded(
                  flex: 6,
                  child: StreamBuilder<PostResponse>(
                    stream: postBloc.subject.stream,
                    builder: (context, AsyncSnapshot<PostResponse> snapshot) {
                      if (snapshot.hasData) {
                        List<Post> posts = snapshot.data.posts;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(children: <Widget>[
                              buildPostItem(posts[index]),
                              SizedBox(height: 6)
                            ]);
                          },
                          itemCount: posts.length,
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return _buildPostLoading();
      },
    );
  }
}
