import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zalo/bloc/comment/comment.dart';
import 'package:zalo/models/comment_response.dart';
import 'package:zalo/repositories/comment_repository.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  @override
  CommentState get initialState => InitialCommentState();

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if (event is LoadingCommentEvent) {
      yield LoadingCommentState();
      try {
        yield await _loadComments(event.index, event.postId);
      } catch (e) {
        yield ErrorCommentState(e.toString());
      }
    }

    if (event is AddCommentEvent) {
      try {
        yield await _addComment(event.comment, event.postId);
      } catch (e) {
        yield ErrorCommentState(e.toString());
      }
    }
  }

  Future<CommentState> _loadComments(int index, int postId) async {
    CommentResponse newState =
        await CommentRepository().getListComments(index, postId);
    return ReceivedCommentState(newState);
  }

  Future<CommentState> _addComment(String comment, int postId) async {
    CommentResponse newState =
        await CommentRepository().addComment(comment, postId);
    return ReceivedCommentState(newState);
  }
}
