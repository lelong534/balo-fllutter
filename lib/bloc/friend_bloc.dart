import 'package:rxdart/rxdart.dart';
import 'package:zalo/models/friend_response.dart';
import 'package:zalo/repositories/friend_repository.dart';

class FriendBloc {
  final FriendRepository _repository = FriendRepository();
  final BehaviorSubject<FriendResponse> _subject =
      BehaviorSubject<FriendResponse>();

  getListFriends(int index, int count) async {
    FriendResponse response = await _repository.getListFriends(index, count);
    _subject.sink.add(response);
  }

  // addComment(String content, int postid) async {
  //   await _repository.addComment(content, postid);
  //   CommentResponse response = await _repository.getListComments(0, postid);
  //   _subject.sink.add(response);
  // }

  void dispose() async {
    _subject.close();
  }

  BehaviorSubject<FriendResponse> get subject => _subject;
}

final friendBloc = FriendBloc();
