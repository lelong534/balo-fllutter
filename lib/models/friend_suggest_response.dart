import 'package:zalo/models/friend_suggest.dart';

class FriendSuggestResponse {
  final List<FriendSuggest> friendSuggests;
  final String error;

  FriendSuggestResponse(this.friendSuggests, this.error);

  FriendSuggestResponse.fromJson(Map<String, dynamic> json)
      : friendSuggests = (json["data"]["list_users"] as List)
            .map((i) => new FriendSuggest.fromJson(i))
            .toList(),
        error = "";

  FriendSuggestResponse.withError(String errorValue)
      : friendSuggests = [],
        error = errorValue;
}
