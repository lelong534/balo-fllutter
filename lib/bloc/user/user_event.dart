import 'package:dio/dio.dart';
import 'package:zalo/models/user_response.dart';

abstract class UserEvent {}

class LoadingUserEvent extends UserEvent {}

class UserChangeAvatarEvent extends UserEvent {
  final MultipartFile avatar;
  final UserResponse user;

  UserChangeAvatarEvent(this.avatar, this.user);

  @override
  String toString() => 'Change avatar';
}

class UserChangeCoverImageEvent extends UserEvent {
  final MultipartFile coverImage;

  UserChangeCoverImageEvent(this.coverImage);

  @override
  String toString() => 'Change coverImage';
}
