import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zalo/models/post_response.dart';

class PostRepository {
  static String mainUrl = "https://bk-zalo.herokuapp.com";
  var getListPostsUrl = '$mainUrl/api/get_list_posts';
  var addPostUrl = '$mainUrl/api/add_post';
  var likePostUrl = '$mainUrl/api/like';
  var unLikePostUrl = '$mainUrl/api/un_like';
  var deletePostUrl = '$mainUrl/api/delete_post';

  final FlutterSecureStorage storage = new FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<PostResponse> getListPosts(int index) async {
    var token = await storage.read(key: "token");
    // var userId = await storage.read(key: "userId");
    try {
      Response response = await _dio.post(getListPostsUrl, data: {
        "token": token,
        // "user_id": userId,
        "index": index,
        "count": 20,
      });
      print(response);
      return PostResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PostResponse.withError("$error");
    }
  }

  Future<void> addPost(
      List<MultipartFile> images, File video, String described) async {
    var token = await storage.read(key: "token");

    try {
      var formData = FormData.fromMap({
        "token": token,
        "image": images,
        "video": video,
        "described": described,
      });
      Response response = await _dio.post(addPostUrl, data: formData);

      print(response);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<void> likePost(int postid) async {
    var token = await storage.read(key: "token");

    try {
      Response response = await _dio.post(likePostUrl, data: {
        "token": token,
        "id": postid,
      });
      print(response);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PostResponse.withError("$error");
    }
  }

  Future<void> unLikePost(int postid) async {
    var token = await storage.read(key: "token");

    try {
      Response response = await _dio.post(unLikePostUrl, data: {
        "token": token,
        "id": postid,
      });
      print(response);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PostResponse.withError("$error");
    }
  }

  Future<void> deletePost(int postid) async {
    var token = await storage.read(key: "token");

    try {
      Response response = await _dio.post(deletePostUrl, data: {
        "token": token,
        "id": postid,
      });
      print(response);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PostResponse.withError("$error");
    }
  }
}
