import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zalo/bloc/user/user.dart';
import 'package:zalo/models/user_response.dart';
import 'package:zalo/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is LoadingUserEvent) {
      yield UserLoading();
      try {
        UserResponse user = await UserRepository().getUserInfo();
        yield UserUpdated(user);
      } catch (e) {
        yield UserFailure(e.toString());
      }
    }
    if (event is UserChangeAvatarEvent) {
      try {
        yield await _changeUserAvatar(event.avatar);
      } catch (e) {
        yield UserFailure(e.toString());
      }
    }
    if (event is LoadUserProfile) {
      yield UserLoading();
      try {
        UserResponse user = await UserRepository().getUserById(event.userId);
        yield UserDetailLoadSuccess(user);
      } catch (e) {
        yield UserFailure(e.toString());
      }
    }

    if (event is UserChangeCoverImageEvent) {
      try {
        UserResponse user =
            await UserRepository().changeUserCoverImage(event.coverImage);
        yield UserUpdated(user);
      } catch (e) {
        yield UserFailure(e.toString());
      }
    }

    if (event is UserChangeInfoEvent) {
      try {
        UserResponse user = await UserRepository()
            .changeUserInfo(event.name, event.description, event.address);
        yield UserUpdated(user);
      } catch (e) {
        yield UserFailure(e.toString());
      }
    }
  }

  Future<UserState> _changeUserAvatar(avatar) async {
    UserResponse newState = await UserRepository().changeUserAvatar(avatar);
    return UserUpdated(newState);
  }
}
