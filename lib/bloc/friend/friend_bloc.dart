import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zalo/bloc/friend/friend.dart';
import 'package:zalo/models/friend_response.dart';
import 'package:zalo/repositories/friend_repository.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  @override
  FriendState get initialState => InitialFriendState();

  @override
  Stream<FriendState> mapEventToState(FriendEvent event) async* {
    if (event is LoadingFriendEvent) {
      yield LoadingFriendState();
      try {
        yield await _loadFriends(event.index, event.count);
      } catch (e) {
        yield ErrorFriendState(e.toString());
      }
    }

    if (event is SearchFriendEvent) {
      try {
        FriendResponse users = await FriendRepository().search(event.query);
        yield FriendSearchSuccess(users);
      } catch (e) {
        yield ErrorFriendState(e.toString());
      }
    }
  }

  Future<FriendState> _loadFriends(int index, int count) async {
    FriendResponse newState =
        await FriendRepository().getListFriends(index, count);
    return ReceivedFriendState(newState);
  }

  
}
