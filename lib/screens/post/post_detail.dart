import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zalo/bloc/comment_bloc.dart';
import 'package:zalo/models/comment.dart';
import 'package:zalo/models/comment_response.dart';
import 'package:zalo/models/post.dart';
import 'package:zalo/screens/post/image_screen.dart';

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

  @override
  void initState() {
    super.initState();
    commentBloc..getListComments(0, postDetail.id);
  }

  void handleLikePostDetail(Post postItem) {
    handleLikePostItem(postItem);
    if (isLikedByUser == false) {
      setState(() {
        isLikedByUser = true;
        countLikes++;
      });
    } else {
      setState(() {
        isLikedByUser = false;
        countLikes--;
      });
    }
  }

  void _handleSubmitComment() {
    commentBloc..addComment(_commentTextController.text, postDetail.id);
    _commentTextController.clear();
  }

  buildPostHeader(Post postItem) {
    var avatarLink;
    avatarLink = postItem.authorAvatar;
    return ListTile(
      leading: avatarLink != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(avatarLink),
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
    );
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

  buildFullScreenImage(String url) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        child: Hero(
          tag: url,
          child: Image.network(url, scale: 0.5),
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

  buildPostComment(Post postItem) {
    return StreamBuilder<CommentResponse>(
      stream: commentBloc.subject.stream,
      builder: (context, AsyncSnapshot<CommentResponse> snapshot) {
        if (snapshot.hasData) {
          List<Comment> comments = snapshot.data.comments;
          print(comments);
          return ListView.builder(
            itemCount: comments.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(children: <Widget>[
                Container(
                    height: 2,
                    color: Colors.black12,
                    width: MediaQuery.of(context).size.width * 0.9),
                ListTile(
                  leading: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: comments[index].authorAvatar != null
                          ? CircleAvatar(
                              radius: 16,
                              backgroundImage:
                                  NetworkImage(comments[index].authorAvatar))
                          : CircleAvatar(
                              radius: 16,
                              child: Text("U"),
                            )),
                  title: Text(
                    comments[index].authorName != null
                        ? comments[index].authorName
                        : "Người dùng",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    comments[index].content,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ]);
            },
          );
        }
        return Container();
      },
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
                  style: TextStyle(fontSize: 18),
                  decoration:
                      InputDecoration.collapsed(hintText: "Nhập bình luận"),
                ),
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(
                  EvaIcons.navigation2,
                  color: Colors.blue,
                ),
                onPressed: _handleSubmitComment,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  buildPostHeader(postDetail),
                  buildPostContent(postDetail),
                  buildPostImage(postDetail),
                  buildPostFooter(postDetail),
                  buildPostComment(postDetail),
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
