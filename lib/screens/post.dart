import 'package:flutter/material.dart';
import 'package:zalo/bloc/post_bloc.dart';
import 'package:zalo/models/post.dart';
import 'package:zalo/models/post_response.dart';
import 'package:zalo/models/user.dart';
import 'package:zalo/models/user_response.dart';
import 'package:zalo/widgets/post_item.dart';
import 'package:zalo/bloc/user_bloc.dart';
import 'post/add.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  void handleLikePostItem(Post postItem) {
    if (postItem.isLiked == false) {
      postBloc..likePost(postItem.id);
    } else {
      postBloc..unLikePost(postItem.id);
    }
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
                user.avatar != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar, scale: 0.1))
                    : CircleAvatar(
                        backgroundImage: AssetImage('assets/avatar.png'),
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
                    user.name != null ? user.name : "Người dùng",
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserResponse>(
      stream: userBloc.subject.stream,
      builder: (context, AsyncSnapshot<UserResponse> snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data.user;
          return Scaffold(
            backgroundColor: Colors.grey[300],
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
                              PostItem(postItem: posts[index]),
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
