import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zalo/bloc/get_post_bloc.dart';
import 'package:zalo/models/post.dart';

class PostDetail extends StatefulWidget {
  final Post postDetail;
  final Function handleLikePostItem;
  final bool isLikedByUser;
  final int countLikes;

  PostDetail(
      {Key key,
      this.postDetail,
      this.isLikedByUser,
      this.countLikes,
      this.handleLikePostItem})
      : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState(
      postDetail, isLikedByUser, countLikes, handleLikePostItem);
}

class _PostDetailState extends State<PostDetail> {
  final Post postDetail;
  final Function handleLikePostItem;
  bool isLikedByUser;
  int countLikes;
  final TextEditingController _commentTextController =
      new TextEditingController();

  _PostDetailState(
    this.postDetail,
    this.isLikedByUser,
    this.countLikes,
    this.handleLikePostItem,
  );

  void handleLikePostDetail(Post postItem) {
    handleLikePostItem(postItem);
    if (isLikedByUser == false) {
      setState(() {
        isLikedByUser = true;
        countLikes++;
      });
      // postBloc..likePost(postItem.id);
    } else {
      setState(() {
        isLikedByUser = false;
        countLikes--;
      });
      // postBloc..unLikePost(postItem.id);
    }
  }

  void _handleSubmitComment(String text) {}

  buildPostHeader(Post postDetail) {
    var avatarLink;
    if (postDetail.authorAvatar == null) {
      avatarLink = "";
      return Container();
    } else {
      avatarLink = postDetail.authorAvatar;
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

  buildPostContent(Post postDetail) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              postDetail.described,
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }

  buildPostImage(Post postDetail) {
    var avatarLink;
    if (postDetail.images.length == 0) {
      avatarLink = "";
      return Container();
    } else {
      avatarLink = postDetail.images[0]["link"];
      return GestureDetector(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image.network(
              avatarLink,
              scale: 0.6,
              fit: BoxFit.cover,
            )),
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
              onTap: () {
                handleLikePostDetail(postItem);
              },
              child: Icon(
                isLikedByUser ? EvaIcons.heart : EvaIcons.heartOutline,
                size: 28.0,
                color: isLikedByUser ? Colors.pink : Colors.black,
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 5.0)),
            Text(countLikes.toString()),
            Padding(padding: EdgeInsets.only(right: 20.0)),
            GestureDetector(
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

  buildComment() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                child: TextField(
                  controller: _commentTextController,
                  onSubmitted: _handleSubmitComment,
                  style: TextStyle(fontSize: 18),
                  decoration:
                      InputDecoration.collapsed(hintText: "Cảm nghĩ của bạn"),
                ),
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(
                  EvaIcons.navigation2,
                  color: Colors.blue,
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bình luận"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildPostHeader(postDetail),
                  buildPostContent(postDetail),
                  buildPostImage(postDetail),
                  buildPostFooter(postDetail),
                ],
              ),
            ),
          ),
          buildComment(),
          SizedBox(height: 14),
        ],
      ),
    );
  }
}
