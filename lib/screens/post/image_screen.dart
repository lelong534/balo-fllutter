import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final String url;
  ImageScreen(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: url,
            child: Image.network(url),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
