import 'package:zalo/models/post.dart';

abstract class FriendEvent {}

class LoadingFriendEvent extends FriendEvent {
  final int index;
  final int count;

  LoadingFriendEvent({this.index, this.count});

  @override
  String toString() => 'Load friends';
}

class SearchFriendEvent extends FriendEvent {
  final String query;

  SearchFriendEvent(this.query);

  @override
  String toString() => 'search user';
}
