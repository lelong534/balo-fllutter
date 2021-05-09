import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zalo/models/comment_response.dart';

class CommentRepository {
  static String mainUrl = "https://bk-zalo.herokuapp.com";
  var getListCommentsUrl = '$mainUrl/api/get_comment';
  var addCommentUrl = '$mainUrl/api/add_comment';

  final FlutterSecureStorage storage = new FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<CommentResponse> getListComments(int index, int postid) async {
    var token = await storage.read(key: "token");
    try {
      Response response = await _dio.post(getListCommentsUrl, data: {
        "token": token,
        "id": postid,
        "index": index,
        "count": 20,
      });
      print(response);
      return CommentResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CommentResponse.withError("$error");
    }
  }

  Future<void> addComment(String content, int postid) async {
    var token = await storage.read(key: "token");

    try {
      var formData = FormData.fromMap({
        "token": token,
        "id": postid,
        "content": content,
      });
      Response response = await _dio.post(addCommentUrl, data: formData);

      print(response);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
