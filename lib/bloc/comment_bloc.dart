import 'package:rxdart/rxdart.dart';
import 'package:zalo/models/comment_response.dart';
import 'package:zalo/repositories/comment_repository.dart';

class CommentBloc {
  final CommentRepository _repository = CommentRepository();
  final BehaviorSubject<CommentResponse> _subject =
      BehaviorSubject<CommentResponse>();

  getListComments(int index, int postid) async {
    CommentResponse response = await _repository.getListComments(index, postid);
    _subject.sink.add(response);
  }

  addComment(String content, int postid) async {
    await _repository.addComment(content, postid);
    CommentResponse response = await _repository.getListComments(0, postid);
    _subject.sink.add(response);
  }

  void dispose() async {
    _subject.close();
  }

  BehaviorSubject<CommentResponse> get subject => _subject;
}

final commentBloc = CommentBloc();
