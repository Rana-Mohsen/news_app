part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}
class SearchSuggetion extends SearchState {}
class SearchResult extends SearchState {}
