import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/models/everything_model.dart';
import 'package:news_app/services/get_articles.dart';

part 'home_categorys_state.dart';

class HomeCategorysCubit extends Cubit<HomeCategorysState> {
  HomeCategorysCubit() : super(HomeCategorysInitial());
  String category = "business";

  categoryChanged(String ctg) {
    category = ctg;
    //getCategoryArticles();
    emit(HomeCategorysChanged());
  }

  // getCategoryArticles() async {
  //   ctgArticles = await AllArticles().get_articls(category);
  // }
}
