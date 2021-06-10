import 'package:zalo/models/search.dart';

abstract class SearchEvent {}

class LoadingSearchEvent extends SearchEvent {
  final String keyword = 'a';


  // LoadingSearchEvent({this.keyword});
  LoadingSearchEvent({keyword});

  @override
  String toString() => 'Load search';
}
