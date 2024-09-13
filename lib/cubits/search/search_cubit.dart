import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  
  searchBody(String para) {
    if (para.isNotEmpty) {
      emit(SearchResult());
    } else {
      emit(SearchSuggetion());
    }
  }
}
