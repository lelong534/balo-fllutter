import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zalo/models/user.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AddPost extends StatefulWidget {
  static String routeName = 'addPost';

  final User currentUser;

  AddPost({this.currentUser});

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File file;
  List<Asset> images = [];
  String errorText;

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    if (images != null)
      return GridView.count(
        crossAxisCount: 2,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      );
    else
      return Container(color: Colors.white);
  }

  Future<void> loadAssets() async {
    setState(() {
      images = [];
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        materialOptions: MaterialOptions(
          actionBarColor: "#b2b2b2",
          actionBarTitleColor: "#FFFFFF",
          statusBarColor: '#b2b2b2',
          selectionLimitReachedText: "Số lượng ảnh đạt giới hạn",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) errorText = 'No Error Dectected';
    });
  }

  clearImage() {
    setState(() {
      images = null;
      Navigator.pop(context);
    });
  }

  Scaffold buildUploadForm() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: clearImage),
        title: Text(
          'Tạo bài viết',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'ĐĂNG',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Bạn đang nghĩ gì?",
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Expanded(
              child: buildGridView(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.collections,
                    color: Colors.green,
                    size: 30,
                  ),
                  onPressed: loadAssets,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildUploadForm();
  }
}
