import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zalo/bloc/post/post_event.dart';
import 'package:zalo/bloc/post/post_state.dart';
import 'package:zalo/models/post_response.dart';
import 'package:zalo/models/user.dart';
import 'package:zalo/repositories/post_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  @override
  PostState get initialState => InitialPostState();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is LoadingPostEvent) {
      yield LoadingPostState();
      try {
        yield await _loadPosts(event.index, event.count);
      } catch (e) {
        yield ErrorPostState(e.toString());
      }
    }

    if (event is LoadingMorePostEvent) {
      try {
        yield await _loadPosts(event.index, event.count);
      } catch (e) {
        yield ErrorPostState(e.toString());
      }
    }

    if (event is LikePostEvent) {
      try {
        yield await _likePost(event.post);
      } catch (e) {
        yield ErrorPostState(e.toString());
      }
    }

    if (event is UnLikePostEvent) {
      try {
        yield await _unLikePost(event.post);
      } catch (e) {
        yield ErrorPostState(e.toString());
      }
    }

    if (event is AddPostEvent) {
      try {
        yield await _addPost(event.images, event.video, event.description);
      } catch (e) {
        yield ErrorPostState(e.toString());
      }
    }

    if (event is LoadingPostByUserEvent) {
      try {
        yield await _loadPostsByUser(event.index, event.count, event.userId);
      } catch (e) {
        yield ErrorPostState(e.toString());
      }
    }
  }

  Future<PostState> _loadPosts(int index, int count) async {
    PostResponse newState = await PostRepository().getListPosts(index, count);
    return ReceivedPostState(newState);
  }

  Future<PostState> _loadPostsByUser(int index, int count, int userId) async {
    PostResponse newState = await PostRepository().getListPostsByUser(index, count, userId);
    return ReceivedPostState(newState);
  }

  Future<PostState> _likePost(post) async {
    PostResponse newState = await PostRepository().likePost(post);
    return ReceivedPostState(newState);
  }

  Future<PostState> _unLikePost(post) async {
    PostResponse newState = await PostRepository().unLikePost(post);
    return ReceivedPostState(newState);
  }

  Future<PostState> _addPost(List<MultipartFile> images, File video, String described) async {
    PostResponse newState = await PostRepository().addPost(images, video, described);
    return ReceivedPostState(newState);
  }
}
