import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zalo/models/user_response.dart';

class UserRepository {
  static String mainUrl = "https://bk-zalo.herokuapp.com";
  var loginUrl = '$mainUrl/api/login';
  var signUpUrl = '$mainUrl/api/signup';
  var getUserInfoUrl = '$mainUrl/api/user/get_user_info';
  var changeUserInfoUrl = '$mainUrl/api/change_user_info';

  final FlutterSecureStorage storage = new FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> persistToken(List userInfo) async {
    await storage.write(key: 'token', value: userInfo[0]);
    await storage.write(key: 'userId', value: userInfo[1].toString());
    await storage.write(key: 'username', value: userInfo[2]);
    await storage.write(key: 'avatar', value: userInfo[3]);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.delete(key: 'userId');
    storage.deleteAll();
  }

  Future<List> login(String phonenumber, String password) async {
    Response response = await _dio.post(loginUrl, data: {
      "phone_number": phonenumber,
      "password": password,
    });
    var userLoginInfo = [];
    userLoginInfo.add(response.data["data"]["token"]);
    userLoginInfo.add(response.data["data"]["id"]);
    userLoginInfo.add(response.data["data"]["username"]);
    userLoginInfo.add(response.data["data"]["avatar"]);

    return userLoginInfo;
  }

  Future<void> signUp(String phonenumber, String password) async {
    try {
      Response response = await _dio.post(signUpUrl, data: {
        "phone_number": phonenumber,
        "password": password,
      });
      print(response);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<UserResponse> getUserInfo() async {
    var token = await storage.read(key: "token");
    try {
      Response response =
          await _dio.post(getUserInfoUrl, data: {"token": token});
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }

  Future<UserResponse> changeUserAvatar(MultipartFile avatar) async {
    var token = await storage.read(key: "token");

    try {
      var formData = FormData.fromMap({
        "token": token,
        "avatar": avatar,
      });

      await _dio.post(changeUserInfoUrl, data: formData);
      Response response =
          await _dio.post(getUserInfoUrl, data: {"token": token});
      print(response);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }

  Future<UserResponse> changeUserCoverImage(MultipartFile coverImage) async {
    var token = await storage.read(key: "token");

    try {
      var formData = FormData.fromMap({
        "token": token,
        "cover_image": coverImage,
      });

      await _dio.post(changeUserInfoUrl, data: formData);
      Response response =
          await _dio.post(getUserInfoUrl, data: {"token": token});
      print(response);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }

  Future<UserResponse> changeUserInfo(
      String name, String description, String address) async {
    var token = await storage.read(key: "token");
    try {
      var formData = FormData.fromMap({
        "token": token,
        "username": name,
        "description": description,
        "address": address
      });

      await _dio.post(changeUserInfoUrl, data: formData);
      Response response =
          await _dio.post(getUserInfoUrl, data: {"token": token});
      print(response);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }
}
