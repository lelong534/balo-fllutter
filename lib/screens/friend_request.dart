import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zalo/bloc/friend_request/friend_request.dart';
import 'package:zalo/models/friend_request.dart';
import 'package:zalo/screens/friend_suggest.dart';

class FriendRequestScreen extends StatefulWidget {
  @override
  _FriendRequestScreenState createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends State<FriendRequestScreen> {
  int index = 0;
  int count = 20;

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
              BlocProvider.of<FriendRequestBloc>(context)
                  .add(AcceptFriendRequestEvent(request));
            },
            child: Text("ĐỒNG Ý",
                style: TextStyle(color: Colors.black, fontSize: 12)),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                return Colors.blue[200];
              }),
            ),
          ),
          IconButton(
              icon: Icon(Icons.close, color: Colors.blue),
              onPressed: () {
                BlocProvider.of<FriendRequestBloc>(context)
                    .add(AcceptFriendRequestEvent(request));
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
      body: BlocProvider<FriendRequestBloc>(
        create: (context) {
          return FriendRequestBloc()
            ..add(LoadingFriendRequestEvent(index: index, count: count));
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: BlocBuilder<FriendRequestBloc, FriendRequestState>(
                    builder: (context, state) {
                      if (state is ReceivedFriendRequestState) {
                        List<FriendRequest> friends =
                            state.friends.friendRequests;
                        if (friends.length != 0) {
                          return ListView.builder(
                            itemCount: friends.length,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) {
                              return _buildFriendRequestItem(friends[index]);
                            },
                          );
                        }
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Text(
                              "Danh sách lời mời kết bạn đang trống",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      } else
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: Center(
                            child: CircularProgressIndicator(),
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
                      return Colors.lightBlue[200];
                    }),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
