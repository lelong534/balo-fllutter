import 'package:rxdart/rxdart.dart';
import 'package:zalo/models/user_response.dart';
import 'package:zalo/repositories/user_repository.dart';

class UserBloc {
  final UserRepository _userRepository = UserRepository();
  final BehaviorSubject<UserResponse> _subject =
      BehaviorSubject<UserResponse>();

  getUser() async {
    UserResponse response = await _userRepository.getUserInfo();
    _subject.sink.add(response);
  }

  signUp(phonenumber, password) async {
    await _userRepository.signUp(phonenumber, password);
  }

  void dispose() async {
    _subject.close();
  }

  BehaviorSubject<UserResponse> get subject => _subject;
}

final userBloc = UserBloc();
