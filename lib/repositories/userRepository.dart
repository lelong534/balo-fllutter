import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zalo/models/user.dart';

class UserRepository {
  static String mainUrl = "https://bk-zalo.herokuapp.com";
  var loginUrl = '$mainUrl/api/login';
  var getUserInfoUrl = '$mainUrl/api/get_user_info';

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

  Future<void> persistToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  Future<String> login(String phonenumber, String password) async {
    Response response = await _dio.post(loginUrl, data: {
      "phone_number": phonenumber,
      "password": password,
    });
    print(response);
    return response.data["data"]["token"];
  }

  Future<User> getUserInfo(userId) async {
    try {
      Response response = await _dio.post(getUserInfoUrl, data: {
        "user_id": userId,
      });

      return User.fromJson(response.data.data);
    } catch (error) {
      print("Exception occured: $error");
    }
  }
}
