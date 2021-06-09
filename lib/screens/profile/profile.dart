import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zalo/bloc/auth/auth.dart';
import 'package:zalo/bloc/post/post.dart';
import 'package:zalo/models/post_response.dart';
import 'package:zalo/models/user_response.dart';
import 'package:zalo/repositories/user_repository.dart';
import 'package:zalo/screens/post/add_post.dart';
import 'package:zalo/screens/profile/body/add_post.dart';
import 'package:zalo/screens/profile/body/body_profile.dart';
import 'package:zalo/screens/profile/header/profile_header.dart';
import 'package:zalo/screens/profile/slide/horizontal_list_asset.dart';

class Profile extends StatefulWidget {
  final UserResponse user;

  Profile({Key key, this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) =>
              AuthenticationBloc(userRepository: UserRepository()),
        ),
        BlocProvider<PostBloc>(
          create: (BuildContext context) => PostBloc()
            ..add(LoadingPostByUserEvent(
                index: 0, count: 20, user: widget.user.user)),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProfileHeader(
                avatar: (widget.user != null && widget.user.user.avatar != null)
                    ? NetworkImage(widget.user.user.avatar, scale: 0.1)
                    : AssetImage('assets/avatar.png'),
                coverImage:
                    (widget.user != null && widget.user.user.coverImage != null)
                        ? NetworkImage(widget.user.user.coverImage)
                        : AssetImage('assets/avatar.png'),
                title: (widget.user != null && widget.user.user.name != null)
                    ? widget.user.user.name
                    : "Người dùng",
                subtitle: (widget.user != null &&
                        widget.user.user.description != null)
                    ? widget.user.user.description
                    : "Thêm giới thiệu bản thân",
              ),
              const SizedBox(height: 10.0),
              HorizontalListAsset(),
              BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                if (state is ReceivedPostState) {
                  PostResponse posts = state.posts;
                  return Column(
                    children: <Widget>[
                      AddPostProfile(
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
                      BodyProfile(posts: posts),
                    ],
                  );
                }
                return Container();
              })
            ],
          ),
        ),
      ),
    );
  }
}
