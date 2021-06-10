import 'package:zalo/models/search.dart';

class SearchResponse {
  final List<Search> searchs;
  final String error;

  SearchResponse(this.searchs, this.error);

  SearchResponse.fromJson(Map<String, dynamic> json)
      : searchs = (json["data"]["user"] as List)
      .map((i) => new Search.fromJson(i))
      .toList(),
        error = "";

  SearchResponse.withError(String errorValue)
      : searchs = [],
        error = errorValue;
}
