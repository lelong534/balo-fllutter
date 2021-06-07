import 'dart:io';
import 'package:dio/dio.dart';
import 'package:zalo/models/post.dart';

abstract class PostEvent {}

class LoadingPostEvent extends PostEvent {
  final index;
  final count;

  LoadingPostEvent({this.index, this.count});

  @override
  String toString() => 'Loading post';
}

class LikePostEvent extends PostEvent {
  final Post post;
  LikePostEvent(this.post);

  @override
  String toString() => 'Like post: $post';
}

class UnLikePostEvent extends PostEvent {
  final Post post;
  UnLikePostEvent(this.post);

  @override
  String toString() => 'UnLike post: $post';
}

class AddPostEvent extends PostEvent {
  final List<MultipartFile> images;
  final File video;
  final String description;

  AddPostEvent({this.images, this.video, this.description});

  @override
  String toString() => 'Add post';
}
