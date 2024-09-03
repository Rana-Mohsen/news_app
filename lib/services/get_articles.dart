import 'package:news_app/models/everything_model.dart';
import 'package:news_app/services/api.dart';
import 'package:news_app/services/apikey.dart';

class AllArticles {
  Future<List<ArticleModel>> get_articls(String keyWord) async {
    dynamic everythingResp = await Api().get(
        url:
            "https://newsapi.org/v2/everything?q=bitcoin&apiKey=$apiKey");

    List<ArticleModel> everyArticles = [];
    for (int i = 0; i < everythingResp["articles"].length; i++) {
      everyArticles
          .add(ArticleModel.fromJson(everythingResp["articles"][i]));
    }

    return everyArticles;
  }
}
