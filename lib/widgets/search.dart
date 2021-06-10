import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zalo/bloc/friend/friend.dart';
import 'package:zalo/models/friend.dart';
import 'package:zalo/screens/profile/profile.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(EvaIcons.close),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider<FriendBloc>(
      create: (BuildContext context) =>
          FriendBloc()..add(SearchFriendEvent(query)),
      child: BlocBuilder<FriendBloc, FriendState>(
        builder: (context, state) {
          if (state is FriendSearchSuccess) {
            List<Friend> friends = state.friends.friends;
            if (friends.length == 0)
              return Center(child: Text("Không có kết quả"));
            return ListView.builder(
              itemCount: friends.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
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
                            userId: friends[index].id,
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: <Widget>[
                        friends[index].avatar != null
                            ? CircleAvatar(
                                backgroundImage:
                                    NetworkImage(friends[index].avatar))
                            : CircleAvatar(child: Text("U")),
                        SizedBox(width: 20),
                        Text(
                            friends[index].username != null
                                ? friends[index].username
                                : "Người dùng",
                            style: TextStyle(color: Colors.black, fontSize: 16))
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
