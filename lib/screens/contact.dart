import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zalo/bloc/friend/friend.dart';
import 'package:zalo/models/friend.dart';
import 'package:zalo/screens/friend_request.dart';
import 'package:zalo/screens/profile/profile.dart';

class Contact extends StatefulWidget {
  static String routeName = "contact";
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FriendBloc>(
        create: (context) {
          return FriendBloc()..add(LoadingFriendEvent());
        },
        child: Column(children: <Widget>[
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
          BlocBuilder<FriendBloc, FriendState>(builder: (context, state) {
            if (state is ReceivedFriendState) {
              List<Friend> friends = state.friends.friends;

              return ListView.builder(
                itemCount: friends.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _buildFriendItem(friends[index]);
                },
              );
            }
            return Container();
          })
        ]));
  }

  Widget _buildFriendItem(Friend friend) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shadowColor: Colors.white12,
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return Profile(
                userId: friend.id,
              );
            },
          ),
        );
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
