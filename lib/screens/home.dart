import 'package:eva_icons_flutter/icon_data.dart';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'post.dart';
import 'group.dart';
import 'contact.dart';
import 'more.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class Message extends StatefulWidget {
  static String routeName = 'message';
  Message({Key key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.messageCircleOutline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.globe2Outline),
            label: 'Danh bạ',
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.peopleOutline),
            label: 'Nhóm',
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.calendarOutline),
            label: 'Nhật ký',
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.settings2Outline),
            label: 'Thêm',
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black26,
        iconSize: 32,
        onTap: (index) {
          setState(() => _currentIndex = index);
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        },
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: <Widget>[
          Chat(),
          Contact(),
          Group(),
          Post(),
          More(),
        ],
      ),
    );
  }
}
