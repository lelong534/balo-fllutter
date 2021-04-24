import 'dart:async';

import 'package:zalo/bloc/auth/auth.dart';
import 'package:zalo/repositories/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final userInfo = await userRepository.login(
          event.phonenumber,
          event.password,
        );
        authenticationBloc.add(LoggedIn(userInfo: userInfo));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
