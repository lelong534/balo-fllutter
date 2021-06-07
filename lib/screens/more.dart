import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zalo/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zalo/bloc/auth/auth.dart';
import 'package:zalo/bloc/user/user.dart';
import 'package:zalo/screens/profile/modal/modal.dart';
import 'package:zalo/screens/profile/profile.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(create: (context) {
      return UserBloc()..add(LoadingUserEvent());
    }, child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserUpdated) {
        var avatar = state.user.user.avatar;
        var username = state.user.user.name;
        var user = state.user;
        return ListView(
          children: <Widget>[
            ListTile(
              leading: avatar != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(avatar, scale: 0.1),
                      radius: 30,
                    )
                  : CircleAvatar(
                      backgroundImage: AssetImage('assets/avatar.png'),
                      radius: 30,
                    ),
              title: GestureDetector(
                child: Text(
                  username != null ? username : "Người dùng",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              subtitle: Text("Xem trang cá nhân"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return Profile(user: state.user);
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Thông tin'),
            ),
            ListTile(
              title: Text('Đổi ảnh đại diện'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return Modal(
                      title: "Ảnh đại diện",
                      takeScreen: "Chụp ảnh mới",
                      takeDevices: "Chọn ảnh từ thiết bị",
                      img: Image.asset(
                        'assets/modalAvatar.jpg',
                        width: 20,
                      ),
                      onSelectGallery: () async {
                        PickedFile pickedFile = await ImagePicker().getImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedFile != null) {
                          File file = File(pickedFile.path);
                          MultipartFile toImage = await MultipartFile.fromFile(
                              file.path,
                              filename: 'avartar.png');
                          BlocProvider.of<UserBloc>(context)
                              .add(UserChangeAvatarEvent(toImage, user));
                        }
                      },
                      onSelectCamera: () async {
                        PickedFile pickedFile = await ImagePicker().getImage(
                          source: ImageSource.camera,
                        );
                        if (pickedFile != null) {
                          File file = File(pickedFile.path);
                          MultipartFile toImage = await MultipartFile.fromFile(
                              file.path,
                              filename: 'avartar.png');
                          BlocProvider.of<UserBloc>(context)
                              .add(UserChangeAvatarEvent(toImage, user));
                        }
                      },
                      user: state.user.user,
                    );
                  },
                );
              },
            ),
            ListTile(
              title: Text('Đổi ảnh bìa'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return Modal(
                      title: "Đổi ảnh bìa",
                      takeScreen: "Chụp ảnh mới",
                      takeDevices: "Chọn ảnh từ thiết bị",
                      img: Image.asset(
                        'assets/modalAvatar.jpg',
                        width: 20,
                      ),
                      onSelectGallery: () async {
                        PickedFile pickedFile = await ImagePicker().getImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedFile != null) {
                          File file = File(pickedFile.path);
                          MultipartFile toImage = await MultipartFile.fromFile(
                              file.path,
                              filename: 'avartar.png');
                          BlocProvider.of<UserBloc>(context)
                              .add(UserChangeCoverImageEvent(toImage));
                        }
                      },
                      onSelectCamera: () async {
                        PickedFile pickedFile = await ImagePicker().getImage(
                          source: ImageSource.camera,
                        );
                        if (pickedFile != null) {
                          File file = File(pickedFile.path);
                          MultipartFile toImage = await MultipartFile.fromFile(
                              file.path,
                              filename: 'avartar.png');
                          BlocProvider.of<UserBloc>(context)
                              .add(UserChangeCoverImageEvent(toImage));
                        }
                      },
                      user: state.user.user,
                    );
                  },
                );
              },
            ),
            ListTile(
              title: Text('Cập nhật giới thiệu bản thân'),
            ),
            ListTile(title: Text('Ví của tôi')),
            ListTile(
              title: Text(
                'Cài đặt',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[400],
                    fontWeight: FontWeight.w700),
              ),
              dense: true,
            ),
            ListTile(
              title: Text('Quản lý tài khoản'),
            ),
            ListTile(
              title: Text('Cài đặt chung'),
            ),
            ListTile(
              title: Text("Đăng xuất"),
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
            ),
          ],
        );
      }
      return Container();
    }));
  }
}
