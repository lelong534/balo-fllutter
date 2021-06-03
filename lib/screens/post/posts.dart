import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zalo/bloc/post/post.dart';
import 'package:zalo/bloc/post/post_bloc.dart';
import 'package:zalo/models/post.dart';
import 'package:zalo/repositories/post_repository.dart';
import 'package:zalo/screens/post/add_post.dart';
import 'package:zalo/screens/post/post_detail/post_detail.dart';
import 'package:zalo/screens/post/post_item.dart';

class PostNew extends StatefulWidget {
  final postRepository = PostRepository();
  @override
  _PostNewState createState() => _PostNewState();
}

class _PostNewState extends State<PostNew> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (context) {
        return PostBloc()..add(LoadingPostEvent());
      },
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is ReceivedPostState) {
            List<Post> posts = state.posts.posts;
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: 80,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Hôm nay bạn thế nào?",
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                          border: InputBorder.none,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) {
                                return AddPost(
                                  onSave: (images, video, description) {
                                    BlocProvider.of<PostBloc>(context).add(
                                      AddPostEvent(
                                        images: images,
                                        video: video,
                                        description: description,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (BuildContext context, index) {
                        final post = posts[index];
                        return PostItem(
                          post: post,
                          onTap: () {
                            if (!post.isLiked)
                              return BlocProvider.of<PostBloc>(context).add(
                                LikePostEvent(post),
                              );
                            else
                              BlocProvider.of<PostBloc>(context).add(
                                UnLikePostEvent(post),
                              );
                          },
                          onDetail: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) {
                                  return PostDetail(
                                    postDetail: post,
                                    onTap: () {
                                      if (!post.isLiked)
                                        return BlocProvider.of<PostBloc>(
                                                context)
                                            .add(
                                          LikePostEvent(post),
                                        );
                                      else
                                        BlocProvider.of<PostBloc>(context).add(
                                          UnLikePostEvent(post),
                                        );
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      itemCount: posts.length,
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
