import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zalo/bloc/comment_bloc.dart';
import 'package:zalo/bloc/post_bloc.dart';
import 'package:zalo/models/post.dart';
import 'package:zalo/screens/post/image_screen.dart';
import 'package:zalo/screens/post/post_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'action_widget.dart';

class PostItem extends StatefulWidget {
  final Post postItem;
  PostItem({Key key, this.postItem}) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState(postItem);
}

class _PostItemState extends State<PostItem> {
  final Post postItem;
  bool isLikedByUser;
  int countLikes;
  int countComments;

  @override
  void initState() {
    isLikedByUser = postItem.isLiked;
    countLikes = postItem.like;
    countComments = postItem.comment;
    super.initState();
  }

  _PostItemState(this.postItem);

  void handleLikePostItem(Post postItem) {
    if (isLikedByUser == false) {
      setState(() {
        isLikedByUser = true;
        countLikes++;
      });
      postBloc..likePost(postItem.id);
    } else {
      setState(() {
        isLikedByUser = false;
        countLikes--;
      });
      postBloc..unLikePost(postItem.id);
    }
  }

  void commentPost(String comment, Post postItem) {
    commentBloc..addComment(comment, postItem.id);
    setState(() {
      countComments++;
    });
  }

  buildPostHeader(Post postItem) {
    var avatarLink;
    avatarLink = postItem.authorAvatar;
    return ListTile(
      leading: avatarLink != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(avatarLink, scale: 0.1),
            )
          : CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
      title: GestureDetector(
        onTap: () => print('showing profile'),
        child: Text(
          postItem.authorName != null ? postItem.authorName : "Người dùng",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      subtitle: Text('3 giờ trước'),
      trailing: IconButton(
        icon: Icon(EvaIcons.moreVerticalOutline),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => ActionWidget(postid: postItem.id));
        },
      ),
    );
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
    if (postItem.images.length == 0) {
      return Container();
    } else if (postItem.images.length == 1) {
      return Container(child: buildFullScreenImage(postItem.images[0]["link"]));
    } else if (postItem.images.length == 2) {
      return Container(
        child: Row(
          children: <Widget>[
            Expanded(child: buildFullScreenImage(postItem.images[0]["link"])),
            Expanded(child: buildFullScreenImage(postItem.images[1]["link"])),
          ],
        ),
      );
    } else if (postItem.images.length == 3) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child:
                            buildFullScreenImage(postItem.images[0]["link"])),
                    Expanded(
                        child:
                            buildFullScreenImage(postItem.images[1]["link"])),
                  ],
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: buildFullScreenImage(postItem.images[2]["link"])),
            ]),
      );
    } else if (postItem.images.length == 4) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: buildFullScreenImage(postItem.images[0]["link"])),
                Expanded(
                    child: buildFullScreenImage(postItem.images[1]["link"])),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: buildFullScreenImage(postItem.images[2]["link"])),
                Expanded(
                    child: buildFullScreenImage(postItem.images[3]["link"])),
              ],
            ),
          ),
        ]),
      );
    } else
      return Container();
  }

  buildFullScreenImage(url) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        // child: Hero(
        //   tag: url,
        //   child: Image.network(
        //     url,
        //     scale: 0.5,
        //   ),
        // ),
        child: CachedNetworkImage(
          placeholder: (context, url) => CircularProgressIndicator(),
          imageUrl: url,
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ImageScreen(url);
          }));
        },
      ),
    );
  }

  buildPostFooter(Post postItem) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 60.0, left: 20.0)),
            GestureDetector(
              onTap: () => handleLikePostItem(postItem),
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
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetail(
                    postDetail: postItem,
                    isLikedByUser: isLikedByUser,
                    countLikes: countLikes,
                    countComments: countComments,
                    commentPost: commentPost,
                    handleLikePostItem: handleLikePostItem,
                  ),
                ),
              ),
              child: Icon(
                EvaIcons.messageCircleOutline,
                size: 28.0,
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 5.0)),
            Text(countComments.toString()),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
}
