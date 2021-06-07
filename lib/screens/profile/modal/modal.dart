import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zalo/models/user.dart';

class Modal extends StatefulWidget {
  final String title, takeScreen, takeDevices;
  final Image img;
  final User user;
  final Function onSelectGallery;
  final Function onSelectCamera;

  const Modal(
      {Key key,
      this.title,
      this.takeScreen,
      this.takeDevices,
      this.img,
      this.user,
      this.onSelectGallery,
      this.onSelectCamera})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<Modal> {
  MultipartFile imageFile;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black, blurRadius: 2),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    height: 200,
                    child: (widget.title == 'Đổi ảnh bìa'
                        ? (widget.user.coverImage != null
                            ? Image.network(widget.user.coverImage,
                                fit: BoxFit.fitWidth)
                            : Image.asset(
                                "assets/avatar.png",
                                fit: BoxFit.fitWidth,
                              ))
                        : (widget.user.avatar != null
                            ? Image.network(widget.user.avatar,
                                fit: BoxFit.fitWidth)
                            : Image.asset(
                                "assets/avatar.png",
                                fit: BoxFit.fitWidth,
                              )))),
                SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.photo_camera, color: Colors.blue[200]),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            child: Text(
                              widget.takeScreen,
                              style: TextStyle(fontSize: 14),
                            ),
                            onTap: widget.onSelectCamera,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.image, color: Colors.blue[200]),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                              child: Text(
                                widget.takeDevices,
                                style: TextStyle(fontSize: 14),
                              ),
                              onTap: widget.onSelectGallery),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
