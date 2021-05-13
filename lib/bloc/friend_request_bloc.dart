import 'package:rxdart/rxdart.dart';
import 'package:zalo/models/friend_request_response.dart';
import 'package:zalo/repositories/friend_repository.dart';

class FriendRequestBloc {
  final FriendRepository _repository = FriendRepository();
  final BehaviorSubject<FriendRequestResponse> _subject =
      BehaviorSubject<FriendRequestResponse>();

  getListFriends(int index, int count) async {
    FriendRequestResponse response =
        await _repository.getListFriendRequest(index, count);
    print(response);
    _subject.sink.add(response);
  }

  acceptFriend(int userid, int status) async {
    await _repository.acceptFriend(userid, status);
    FriendRequestResponse response =
        await _repository.getListFriendRequest(0, 20);
    _subject.sink.add(response);
  }

  rejectFriend(int userid) async {
    await _repository.rejectFriend(userid);
    FriendRequestResponse response =
        await _repository.getListFriendRequest(0, 20);
    _subject.sink.add(response);
  }

  void dispose() async {
    _subject.close();
  }

  BehaviorSubject<FriendRequestResponse> get subject => _subject;
}

final friendRequestBloc = FriendRequestBloc();
