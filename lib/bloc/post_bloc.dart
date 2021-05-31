import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zalo/models/post_response.dart';
import 'package:zalo/repositories/post_repository.dart';

class PostBloc {
  final PostRepository _repository = PostRepository();
  final BehaviorSubject<PostResponse> _subject =
      BehaviorSubject<PostResponse>();

  getListPosts(int index) async {
    PostResponse response = await _repository.getListPosts(index);
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

  deletePost(int postid) async {
    await _repository.deletePost(postid);
    PostResponse response = await _repository.getListPosts(0);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<PostResponse> get subject => _subject.stream;
}

final postBloc = PostBloc();
