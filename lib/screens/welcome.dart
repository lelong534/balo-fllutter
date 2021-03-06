import 'package:flutter/material.dart';
import 'package:zalo/repositories/user_repository.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:zalo/screens/login.dart';

class Welcome extends StatefulWidget {
  final UserRepository userRepository;
  const Welcome({Key key, @required this.userRepository}) : super(key: key);

  static String routeName = 'welcome';

  @override
  _WelcomeState createState() => _WelcomeState(userRepository);
}

class _WelcomeState extends State<Welcome> {
  final UserRepository userRepository;
  _WelcomeState(this.userRepository);

  bool clicked = false;
  void afterIntroComplete() {
    setState(() {
      clicked = true;
    });
  }

  final List<PageViewModel> pages = [
    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          Text(
            'ĐẠI HỌC BÁCH KHOA HÀ NỘI',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
      body: "Một tình yêu, một tương lai.",
      image: Image.asset(
        'assets/logo.png',
        width: 100,
      ),
      decoration: const PageDecoration(
        pageColor: Colors.white,
        bodyTextStyle: TextStyle(
          color: Colors.black54,
          fontSize: 16,
        ),
        descriptionPadding: EdgeInsets.only(left: 20, right: 20),
        imagePadding: EdgeInsets.all(20),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return clicked
        ? Login(userRepository: userRepository)
        : IntroductionScreen(
            pages: pages,
            onDone: () {
              afterIntroComplete();
            },
            onSkip: () {
              afterIntroComplete();
            },
            skip: const Text(
              'Skip',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            next: const Icon(Icons.navigate_next),
            done: const Text(
              "DONE",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            dotsDecorator: DotsDecorator(
              size: const Size.square(7.0),
              activeSize: const Size(20.0, 5.0),
              activeColor: Colors.black,
              color: Colors.black12,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          );
  }
}
