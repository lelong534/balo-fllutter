import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zalo/models/friend_response.dart';

class FriendRepository {
  static String mainUrl = "https://bk-zalo.herokuapp.com";
  var getListFriendsUrl = '$mainUrl/api/user/get_user_friend';
  var addCommentUrl = '$mainUrl/api/add_comment';

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
}
