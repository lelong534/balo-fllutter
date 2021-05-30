import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final String url;
  ImageScreen(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: url,
            child: Image.network(url, scale: 0.2),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
