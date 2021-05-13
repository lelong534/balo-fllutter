import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zalo/models/friend_request_response.dart';
import 'package:zalo/models/friend_response.dart';
import 'package:zalo/models/friend_suggest_response.dart';

class FriendRepository {
  static String mainUrl = "https://bk-zalo.herokuapp.com";
  var getListFriendsUrl = '$mainUrl/api/user/get_user_friends';
  var addCommentUrl = '$mainUrl/api/add_comment';
  var getListFriendRequestUrl = '$mainUrl/api/user/get_requested_friends';
  var setAcceptFriend = '$mainUrl/api/user/set_accept_friend';
  var getListFriendSuggestUrl = "$mainUrl/api/user/get_suggested_friends";
  var setRequestFriendUrl = "$mainUrl/api/user/set_request_friends";

  final FlutterSecureStorage storage = new FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<FriendResponse> getListFriends(int index, int count) async {
    var token = await storage.read(key: "token");
    try {
      Response response = await _dio.post(getListFriendsUrl, data: {
        "token": token,
        "index": index,
        "count": count,
      });
      print(response);
      return FriendResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return FriendResponse.withError("$error");
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

  Future<FriendRequestResponse> getListFriendRequest(
      int index, int count) async {
    var token = await storage.read(key: "token");
    try {
      Response response = await _dio.post(getListFriendRequestUrl, data: {
        "token": token,
        "index": index,
        "count": count,
      });
      print(response);
      return FriendRequestResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return FriendRequestResponse.withError("$error");
    }
  }

  Future<FriendSuggestResponse> getListSuggestRequest(
      int index, int count) async {
    var token = await storage.read(key: "token");
    try {
      Response response = await _dio.post(getListFriendSuggestUrl, data: {
        "token": token,
        "index": index,
        "count": count,
      });
      print(response);
      return FriendSuggestResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return FriendSuggestResponse.withError("$error");
    }
  }

  Future<void> acceptFriend(int userid, int status) async {
    var token = await storage.read(key: "token");

    try {
      var formData = FormData.fromMap({
        "token": token,
        "user_id": userid,
        "is_accepted": status,
      });
      Response response = await _dio.post(setAcceptFriend, data: formData);

      print(response);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<void> rejectFriend(int userid) async {
    var token = await storage.read(key: "token");

    try {
      var formData = FormData.fromMap({
        "token": token,
        "user_id": userid,
        "is_accepted": 0,
      });
      Response response = await _dio.post(setAcceptFriend, data: formData);

      print(response);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<void> requestFriend(int userid) async {
    var token = await storage.read(key: "token");

    try {
      var formData = FormData.fromMap({
        "token": token,
        "user_id": userid,
      });
      Response response = await _dio.post(setRequestFriendUrl, data: formData);

      print(response);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
