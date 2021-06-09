import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zalo/models/post.dart';
import 'package:zalo/models/post_response.dart';
import 'package:zalo/models/user.dart';

class PostRepository {
  static String mainUrl = "https://bk-zalo.herokuapp.com";
  var getListPostsUrl = '$mainUrl/api/get_list_posts';
  var addPostUrl = '$mainUrl/api/add_post';
  var likePostUrl = '$mainUrl/api/like';
  var unLikePostUrl = '$mainUrl/api/un_like';
  var deletePostUrl = '$mainUrl/api/delete_post';

  final FlutterSecureStorage storage = new FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<PostResponse> getListPosts(int index, int count) async {
    var token = await storage.read(key: "token");
    try {
      Response response = await _dio.post(getListPostsUrl, data: {
        "token": token,
        "index": index,
        "count": count,
      });
      return PostResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PostResponse.withError("$error");
    }
  }

  Future<PostResponse> getListPostsByUser(
      int index, int count, User user) async {
    var token = await storage.read(key: "token");
    try {
      Response response = await _dio.post(getListPostsUrl, data: {
        "token": token,
        "index": index,
        "count": count,
        "user_id": user.id
      });
      return PostResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PostResponse.withError("$error");
    }
  }

  Future<PostResponse> addPost(
      List<MultipartFile> images, File video, String described) async {
    var token = await storage.read(key: "token");

    try {
      var formData = FormData.fromMap({
        "token": token,
        "image": images,
        "video": video,
        "described": described,
      });
      await _dio.post(addPostUrl, data: formData);

      Response response = await _dio.post(getListPostsUrl, data: {
        "token": token,
        "index": 0,
        "count": 20,
      });
      return PostResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PostResponse.withError("$error");
    }
  }

  Future<PostResponse> likePost(Post post) async {
    var token = await storage.read(key: "token");

    try {
      await _dio.post(likePostUrl, data: {
        "token": token,
        "id": post.id,
      });

      Response response = await _dio.post(getListPostsUrl, data: {
        "token": token,
        "index": 0,
        "count": 20,
      });
      return PostResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PostResponse.withError("$error");
    }
  }

  Future<PostResponse> unLikePost(Post post) async {
    var token = await storage.read(key: "token");

    try {
      await _dio.post(unLikePostUrl, data: {
        "token": token,
        "id": post.id,
      });

      Response response = await _dio.post(getListPostsUrl, data: {
        "token": token,
        "index": 0,
        "count": 20,
      });
      return PostResponse.fromJson(response.data);
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
