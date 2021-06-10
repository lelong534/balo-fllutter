import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zalo/screens/search/discovery/list_discovery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zalo/bloc/search/search.dart';
import 'package:zalo/models/search.dart';


class SearchAll extends SearchDelegate {

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(FontAwesomeIcons.qrcode),
        onPressed: () {},
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

  // @override
  // Widget buildResults(BuildContext context) {
  //   return Container(
  //     child: Text('Result'),
  //   );
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: ListDicovery(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider<SearchBloc>(
        create: (context) {
          return SearchBloc()..add(LoadingSearchEvent());
        },
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 30,
              child: Text(
                "Danh sách tim kiem",
                style: TextStyle(),
              ),
            ),
          ),
          BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
            if (state is ReceivedSearchState) {
              List<Search> searchs = state.searchs.searchs;

              return ListView.builder(
                itemCount: searchs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _buildSearchItem(searchs[index]);
                },
              );
            }
            return Container();
          })
        ]));
  }

  Widget _buildSearchItem(Search search) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shadowColor: Colors.white12,
      ),
      onPressed: () {
        print("test");
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            search.avatar != null
                ? CircleAvatar(backgroundImage: NetworkImage(search.avatar))
                : CircleAvatar(child: Text("U")),
            SizedBox(width: 20),
            Text(search.username != null ? search.username : "Người dùng",
                style: TextStyle(color: Colors.black, fontSize: 16))
          ],
        ),
      ),
    );
  }


}
