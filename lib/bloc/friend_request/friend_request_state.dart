import 'package:equatable/equatable.dart';
import 'package:zalo/models/friend_request_response.dart';

abstract class FriendRequestState extends Equatable {}

class InitialFriendRequestState extends FriendRequestState {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => 'Initial friend';
}

class ReceivedFriendRequestState extends FriendRequestState {
  final FriendRequestResponse friends;

  ReceivedFriendRequestState(this.friends);

  @override
  List<Object> get props => [friends];

  @override
  String toString() => 'Received Friend';
}

class ErrorFriendRequestState extends FriendRequestState {
  final String errorMessage;

  ErrorFriendRequestState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'Error: ' + errorMessage;
}

class LoadingFriendRequestState extends FriendRequestState {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => 'Loading';
}
