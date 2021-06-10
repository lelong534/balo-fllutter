import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zalo/models/post.dart';

class PostHeader extends StatelessWidget {
  final Post post;

  PostHeader(this.post);

  @override
  Widget build(BuildContext context) {
    var avatarLink;
    avatarLink = post.authorAvatar;
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
          post.authorName != null ? post.authorName : "Người dùng",
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
          // showModalBottomSheet(
          // context: context,
          // builder: (context) => ActionWidget(postid: post.id));
        },
      ),
    );
  }
}
