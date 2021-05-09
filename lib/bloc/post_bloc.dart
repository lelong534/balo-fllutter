import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zalo/models/post_response.dart';
import 'package:zalo/repositories/post_repository.dart';

class PostBloc {
  final PostRepository _repository = PostRepository();
  final BehaviorSubject<PostResponse> _subject =
      BehaviorSubject<PostResponse>();

  getListPosts(int index) async {
    PostResponse response = await _repository.getListPosts(index);
    print(response);
    _subject.sink.add(response);
  }

  addPost(List<MultipartFile> images, File video, String described) async {
    await _repository.addPost(images, video, described);
    PostResponse response = await _repository.getListPosts(0);
    _subject.sink.add(response);
  }

  likePost(int postid) async {
    await _repository.likePost(postid);
    PostResponse response = await _repository.getListPosts(0);
    _subject.sink.add(response);
  }

  unLikePost(int postid) async {
    await _repository.unLikePost(postid);
    PostResponse response = await _repository.getListPosts(0);
    _subject.sink.add(response);
  }

  void dispose() async {
    _subject.close();
  }

  BehaviorSubject<PostResponse> get subject => _subject;
}

final postBloc = PostBloc();
