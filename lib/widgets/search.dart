import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zalo/screens/search/discovery/list_discovery.dart';

class Search extends SearchDelegate {

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      // IconButton(
      //   icon: Icon(EvaIcons.searchOutline),
      //   onPressed: () {},
      // ),
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

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Text('Result'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: ListDicovery(),
    );
  }
}
