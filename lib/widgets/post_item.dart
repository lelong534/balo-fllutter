import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zalo/bloc/get_post_bloc.dart';
import 'package:zalo/models/post.dart';
import 'package:zalo/screens/post/post_detail.dart';

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

  @override
  void initState() {
    isLikedByUser = postItem.isLiked;
    countLikes = postItem.like;
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
            Text('2'),
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
