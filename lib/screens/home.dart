import 'package:flutter/material.dart';
import 'chat.dart';
import 'post.dart';
import 'group.dart';
import 'contact.dart';
import 'more.dart';

// class Message extends StatefulWidget {
//   static String routeName = 'message';
//   Message({Key key}) : super(key: key);

//   @override
//   _MessageState createState() => _MessageState();
// }

// class _MessageState extends State<Message> {
//   int _currentIndex = 0;
//   PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavyBar(
//         selectedIndex: _currentIndex,
//         onItemSelected: (index) {
//           setState(() => _currentIndex = index);
//           _pageController.jumpToPage(index);
//         },
//         items: <BottomNavyBarItem>[
//           BottomNavyBarItem(
//             icon: Icon(Icons.chat_outlined),
//             title: Text('Chat'),
//             activeColor: Colors.blueAccent,
//             inactiveColor: Colors.black,
//             textAlign: TextAlign.center,
//           ),
//           BottomNavyBarItem(
//             icon: Icon(Icons.contact_page_outlined),
//             title: Text('Danh bạ'),
//             activeColor: Colors.blueAccent,
//             inactiveColor: Colors.black,
//             textAlign: TextAlign.center,
//           ),
//           BottomNavyBarItem(
//             icon: Icon(Icons.group_outlined),
//             title: Text('Chat'),
//             activeColor: Colors.blueAccent,
//             inactiveColor: Colors.black,
//             textAlign: TextAlign.center,
//           ),
//           BottomNavyBarItem(
//             icon: Icon(Icons.watch_later_outlined),
//             title: Text('Nhật ký'),
//             activeColor: Colors.blueAccent,
//             inactiveColor: Colors.black,
//             textAlign: TextAlign.center,
//           ),
//           BottomNavyBarItem(
//             icon: Icon(Icons.grid_view),
//             title: Text('Thêm'),
//             activeColor: Colors.blueAccent,
//             inactiveColor: Colors.black,
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() => _currentIndex = index);
//         },
//         children: <Widget>[
//           Chat(),
//           Contact(),
//           Group(),
//           Post(),
//           More(),
//         ],
//       ),
//     );
//   }
// }

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
        selectedFontSize: 10,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.portrait),
            label: 'Danh bạ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            label: 'Nhật ký',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_customize),
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
          // _pageController.jumpToPage(index);
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
