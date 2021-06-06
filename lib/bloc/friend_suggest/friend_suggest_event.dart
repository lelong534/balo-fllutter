import 'package:zalo/models/friend_suggest.dart';

abstract class FriendSuggestEvent {}

class LoadingFriendSuggestEvent extends FriendSuggestEvent {
  final int index;
  final int count;

  LoadingFriendSuggestEvent({this.index, this.count});

  @override
  String toString() => 'Load friends Suggests';
}

class RequestFriendSuggestEvent extends FriendSuggestEvent {
  final FriendSuggest friend;

  RequestFriendSuggestEvent(this.friend);

  @override
  String toString() => 'Accept friend';
}
