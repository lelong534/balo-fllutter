import 'package:equatable/equatable.dart';
import 'package:zalo/models/search_response.dart';

abstract class SearchState extends Equatable {}

class InitialSearchState extends SearchState {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => 'Initial Search';
}

class ReceivedSearchState extends SearchState {
  final SearchResponse searchs;

  ReceivedSearchState(this.searchs);

  @override
  List<Object> get props => [searchs];

  @override
  String toString() => 'Received searchs';
}

class ErrorSearchState extends SearchState {
  final String errorMessage;

  ErrorSearchState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'Error: ' + errorMessage;
}

class LoadingSearchState extends SearchState {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => 'Loading';
}
