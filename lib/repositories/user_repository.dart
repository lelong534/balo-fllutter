import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zalo/models/user_response.dart';

class UserRepository {
  static String mainUrl = "https://bk-zalo.herokuapp.com";
  var loginUrl = '$mainUrl/api/login';
  var signUpUrl = '$mainUrl/api/signup';
  var getUserInfoUrl = '$mainUrl/api/user/get_user_info';

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
    var userId = await storage.read(key: "userId");
    try {
      Response response = await _dio.post(getUserInfoUrl, data: {
        "token": token,
        "user_id": userId,
      });
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }
}
