import 'package:rxdart/rxdart.dart';
import 'package:zalo/models/friend_suggest_response.dart';
import 'package:zalo/repositories/friend_repository.dart';

class FriendSuggestBloc {
  final FriendRepository _repository = FriendRepository();
  final BehaviorSubject<FriendSuggestResponse> _subject =
      BehaviorSubject<FriendSuggestResponse>();

  getListSuggests(int index, int count) async {
    FriendSuggestResponse response =
        await _repository.getListSuggestRequest(index, count);
    _subject.sink.add(response);
  }

  requestFriend(int userid) async {
    await _repository.requestFriend(userid);
    FriendSuggestResponse response =
        await _repository.getListSuggestRequest(0, 20);
    _subject.sink.add(response);
  }

  // acceptFriend(int userid, int status) async {
  //   await _repository.acceptFriend(userid, status);
  //   FriendRequestResponse response =
  //       await _repository.getListFriendRequest(0, 20);
  //   _subject.sink.add(response);
  // }

  // rejectFriend(int userid) async {
  //   await _repository.rejectFriend(userid);
  //   FriendRequestResponse response =
  //       await _repository.getListFriendRequest(0, 20);
  //   _subject.sink.add(response);
  // }

  void dispose() async {
    _subject.close();
  }

  BehaviorSubject<FriendSuggestResponse> get subject => _subject;
}

final friendSuggestBloc = FriendSuggestBloc();
