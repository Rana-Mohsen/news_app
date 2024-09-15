import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/models/everything_model.dart';

part 'favorit_state.dart';

class FavoritCubit extends Cubit<FavoritState> {
  FavoritCubit() : super(FavoritInitial());
  List<ArticleModel> favArticles = [];
  favoritBody() {
    if (favArticles.isEmpty) {
      emit(NoFavorits());
    } else {
      emit(ShowFavorits());
    }
  }

  addFavorit(ArticleModel fav) {
    favArticles.add(fav);
    fav.isFav = true;
  }

  removeFavorit(ArticleModel fav) {
    favArticles.remove(fav);
    fav.isFav = false;
  }
}
