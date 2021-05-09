import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zalo/bloc/post_bloc.dart';
import 'package:zalo/models/user.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:zalo/screens/home.dart';
import 'package:zalo/screens/post.dart';
import 'package:zalo/screens/welcome.dart';

class AddPost extends StatefulWidget {
  static String routeName = 'addPost';

  final User currentUser;

  AddPost({this.currentUser});

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File video;
  List<Asset> imagesAsset = [];
  String errorText;
  final _describedController = TextEditingController();
  List<MultipartFile> imagesFile = [];

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    if (imagesAsset != null)
      return GridView.count(
        crossAxisCount: 2,
        children: List.generate(imagesAsset.length, (index) {
          Asset asset = imagesAsset[index];
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
      imagesAsset = [];
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

    for (var asset in resultList) {
      ByteData byteData = await asset.getByteData(quality: 80);

      if (byteData != null) {
        List<int> imageData = byteData.buffer.asUint8List();
        MultipartFile multipartFile = MultipartFile.fromBytes(
          imageData,
          filename: 'test.jpg',
        );
        imagesFile.add(multipartFile);
      }
    }

    setState(() {
      imagesAsset = resultList;
      if (error == null) errorText = 'No Error Dectected';
    });
  }

  void _submitAddPostForm() {
    postBloc..addPost(imagesFile, video, _describedController.text);
    Navigator.pushNamed(context, Message.routeName);
  }

  clearImage() {
    setState(() {
      imagesFile = null;
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
              onPressed: _submitAddPostForm,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Form(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _describedController,
                decoration: InputDecoration(
                  hintText: "Bạn đang nghĩ gì?",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          Expanded(
            child: buildGridView(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              child: Text("Chọn ảnh"),
              onPressed: loadAssets,
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildUploadForm();
  }
}
