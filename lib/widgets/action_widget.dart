import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zalo/bloc/post_bloc.dart';

class ActionWidget extends StatelessWidget {
  final int postid;

  ActionWidget({this.postid});

  void deletePost(int postid) {
    postBloc..deletePost(postid);
    postBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                children: <Widget>[
                  Icon(EvaIcons.trashOutline, color: Colors.black87, size: 30),
                  SizedBox(width: 20),
                  TextButton(
                    child: Text(
                      "Xóa bài viết",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                    onPressed: () {
                      deletePost(postid);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
