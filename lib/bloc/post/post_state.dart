import 'package:equatable/equatable.dart';
import 'package:zalo/models/post_response.dart';

abstract class PostState extends Equatable {}

class InitialPostState extends PostState {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => 'Initial';
}

class ReceivedPostState extends PostState {
  final PostResponse posts;

  ReceivedPostState(this.posts);

  @override
  List<Object> get props => [posts];

  @override
  String toString() => 'Received Post';
}

class ErrorPostState extends PostState {
  final String errorMessage;

  ErrorPostState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'Error: ' + errorMessage;
}

class LoadingPostState extends PostState {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => 'Loading';
}
