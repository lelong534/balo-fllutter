import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:zalo/models/friend_response.dart';
// import 'package:zalo/models/friend_suggest_response.dart';
import 'package:zalo/models/search_response.dart';

class SearchRepository {
  static String mainUrl = "https://bk-zalo.herokuapp.com";
  var getListSearchsUrl = '$mainUrl/api/search';


  final FlutterSecureStorage storage = new FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<SearchResponse> getListSearchs(String keyword) async {
    var token = await storage.read(key: "token");
    try {
      Response response = await _dio.post(getListSearchsUrl, data: {
        "token": token,
        "keyword": keyword

      });
   print("da nhap la : " + keyword);
      print(response);
      return SearchResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return SearchResponse.withError("$error");
    }
  }
}
