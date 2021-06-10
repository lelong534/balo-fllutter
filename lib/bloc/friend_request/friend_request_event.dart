import 'package:zalo/models/friend_request.dart';

abstract class FriendRequestEvent {}

class LoadingFriendRequestEvent extends FriendRequestEvent {
  final int index;
  final int count;

  LoadingFriendRequestEvent({this.index, this.count});

  @override
  String toString() => 'Load friends requests';
}

class AcceptFriendRequestEvent extends FriendRequestEvent {
  final FriendRequest friend;

  AcceptFriendRequestEvent(this.friend);

  @override
  String toString() => 'Accept friend';
}

class RejectFriendRequestEvent extends FriendRequestEvent {
  final FriendRequest friend;

  RejectFriendRequestEvent(this.friend);

  @override
  String toString() => 'Reject friend';
}
