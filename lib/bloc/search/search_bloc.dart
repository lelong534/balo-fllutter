import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zalo/bloc/search/search.dart';
import 'package:zalo/models/search_response.dart';
import 'package:zalo/repositories/search_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  @override
  SearchState get initialState => InitialSearchState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is LoadingSearchEvent) {
      yield LoadingSearchState();
      try {
        yield await _loadSearchs(event.keyword);
      } catch (e) {
        yield ErrorSearchState(e.toString());
      }
    }
  }

  Future<SearchState> _loadSearchs(String keyword) async {
    SearchResponse newState =
        await SearchRepository().getListSearchs(keyword);
    return ReceivedSearchState(newState);
  }
}
