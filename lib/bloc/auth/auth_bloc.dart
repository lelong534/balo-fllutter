import 'dart:async';
import 'package:zalo/models/user_response.dart';
import 'package:zalo/repositories/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'auth.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUnitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();
      if (hasToken) {
        UserResponse user = await userRepository.getUserInfo();
        yield AuthenticationAuthenticated(user);
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistToken(event.userInfo);
      UserResponse user = await userRepository.getUserInfo();
      yield AuthenticationAuthenticated(user);
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
