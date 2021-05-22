import 'package:flutter/material.dart';
import 'package:zalo/bloc/friend_suggest_bloc.dart';
import 'package:zalo/models/friend_suggest.dart';
import 'package:zalo/models/friend_suggest_response.dart';

class FriendSuggestScreen extends StatefulWidget {
  static String routeName = 'friend_suggest_screen';
  @override
  _FriendSuggestScreenState createState() => _FriendSuggestScreenState();
}

class _FriendSuggestScreenState extends State<FriendSuggestScreen> {
  @override
  void initState() {
    super.initState();
    friendSuggestBloc..getListSuggests(0, 20);
  }

  void sendRequestFriend(int userid) {
    friendSuggestBloc..requestFriend(userid);
  }

  void requestFriend(FriendSuggest friend) {}
  _buildFriendSuggestItem(FriendSuggest user) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: <Widget>[
          user.avatar != null
              ? CircleAvatar(backgroundImage: NetworkImage(user.avatar))
              : CircleAvatar(child: Text("U")),
          SizedBox(width: 20),
          Text(user.username != null ? user.username : "Người dùng",
              style: TextStyle(color: Colors.black, fontSize: 16)),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              sendRequestFriend(user.id);
            },
            child: Text("Kết bạn",
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gợi ý kết bạn"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: StreamBuilder<FriendSuggestResponse>(
                  stream: friendSuggestBloc.subject.stream,
                  builder:
                      (context, AsyncSnapshot<FriendSuggestResponse> snapshot) {
                    if (snapshot.hasData) {
                      List<FriendSuggest> friends =
                          snapshot.data.friendSuggests;
                      return ListView.builder(
                        itemCount: friends.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          return _buildFriendSuggestItem(friends[index]);
                        },
                      );
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
