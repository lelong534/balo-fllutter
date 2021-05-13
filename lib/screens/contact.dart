import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zalo/bloc/friend_bloc.dart';
import 'package:zalo/models/friend.dart';
import 'package:zalo/models/friend_response.dart';
import 'package:zalo/screens/friend_request.dart';

class Contact extends StatefulWidget {
  static String routeName = "contact";
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  void initState() {
    super.initState();
    friendBloc..getListFriends(0, 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                return Colors.white;
              }),
              shadowColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                return Colors.white;
              }),
              overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.black12;
                return null;
              }),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new FriendRequestScreen()),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blue,
                    child: Icon(EvaIcons.peopleOutline, color: Colors.white),
                  ),
                  SizedBox(width: 20),
                  Text("Lời mời kết bạn",
                      style: TextStyle(color: Colors.black, fontSize: 16))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 30,
              child: Text(
                "Danh sách bạn bè",
                style: TextStyle(),
              ),
            ),
          ),
          StreamBuilder<FriendResponse>(
            stream: friendBloc.subject.stream,
            builder: (context, AsyncSnapshot<FriendResponse> snapshot) {
              if (snapshot.hasData) {
                List<Friend> friends = snapshot.data.friends;
                return ListView.builder(
                  itemCount: friends.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _buildFriendItem(friends[index]);
                  },
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFriendItem(Friend friend) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shadowColor: Colors.white12,
      ),
      onPressed: () {
        print("tap");
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            friend.avatar != null
                ? CircleAvatar(backgroundImage: NetworkImage(friend.avatar))
                : CircleAvatar(child: Text("U")),
            SizedBox(width: 20),
            Text(friend.username != null ? friend.username : "Người dùng",
                style: TextStyle(color: Colors.black, fontSize: 16))
          ],
        ),
      ),
    );
  }
}
