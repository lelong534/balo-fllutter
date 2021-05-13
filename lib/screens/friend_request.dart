import 'package:flutter/material.dart';
import 'package:zalo/bloc/friend_request_bloc.dart';
import 'package:zalo/models/friend_request.dart';
import 'package:zalo/models/friend_request_response.dart';
import 'package:zalo/screens/friend_suggest.dart';

class FriendRequestScreen extends StatefulWidget {
  @override
  _FriendRequestScreenState createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends State<FriendRequestScreen> {
  @override
  void initState() {
    super.initState();
    friendRequestBloc..getListFriends(0, 20);
  }

  void acceptFriend(FriendRequest friend) {
    friendRequestBloc..acceptFriend(friend.id, 1);
  }

  void rejectFriend(FriendRequest friend) {
    friendRequestBloc..rejectFriend(friend.id);
  }

  _buildFriendRequestItem(FriendRequest request) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: <Widget>[
          request.avatar != null
              ? CircleAvatar(backgroundImage: NetworkImage(request.avatar))
              : CircleAvatar(child: Text("U")),
          SizedBox(width: 20),
          Text(request.username != null ? request.username : "Người dùng",
              style: TextStyle(color: Colors.black, fontSize: 16)),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              acceptFriend(request);
            },
            child: Text("ĐỒNG Ý",
                style: TextStyle(color: Colors.black, fontSize: 12)),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                return Colors.teal[100];
              }),
            ),
          ),
          IconButton(
              icon: Icon(Icons.close, color: Colors.blue),
              onPressed: () {
                rejectFriend(request);
              },
              padding: EdgeInsets.all(0))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lời mời kết bạn"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: StreamBuilder<FriendRequestResponse>(
                  stream: friendRequestBloc.subject.stream,
                  builder:
                      (context, AsyncSnapshot<FriendRequestResponse> snapshot) {
                    if (snapshot.hasData) {
                      List<FriendRequest> friends =
                          snapshot.data.friendRequests;
                      return ListView.builder(
                        itemCount: friends.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          return _buildFriendRequestItem(friends[index]);
                        },
                      );
                    } else
                      return Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(
                          "Danh sách lời mời kết bạn đang trống",
                          style: TextStyle(
                              fontSize: 16,
                              backgroundColor: Colors.transparent),
                        ),
                      );
                  },
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, FriendSuggestScreen.routeName);
                },
                child: Padding(
                    padding: EdgeInsets.all(14),
                    child: Text("Tìm thêm bạn",
                        style: TextStyle(color: Colors.black))),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return Colors.white;
                  }),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
