import 'package:zalo/models/post.dart';

abstract class CommentEvent {}

class LoadingCommentEvent extends CommentEvent {
  final int index;
  final int postId;

  LoadingCommentEvent({this.index, this.postId});

  @override
  String toString() => 'Load comments';
}

class AddCommentEvent extends CommentEvent {
  final String comment;
  final int postId;

  AddCommentEvent({this.comment, this.postId});

  @override
  String toString() => 'Add comment';
}
