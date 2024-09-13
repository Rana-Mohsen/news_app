import 'package:news_app/models/everything_model.dart';
import 'package:news_app/services/api.dart';
import 'package:news_app/services/apikey.dart';

class AllArticles {
  Future<List<ArticleModel>> getCtgArticls(
      {String keyWord = "business"}) async {
    dynamic everythingResp = await Api().get(
        url:
            "https://newsapi.org/v2/top-headlines?country=us&category=$keyWord&apiKey=$apiKey");

    List<ArticleModel> everyArticles = [];
    for (int i = 0; i < everythingResp["articles"].length; i++) {
      if (everythingResp["articles"][i]["title"] == "[Removed]") {
        continue;
      }
      if (everythingResp["articles"][i]["urlToImage"] == null) {
        everythingResp["articles"][i]["urlToImage"] =
            "https://th.bing.com/th/id/OIP.NPpdGIpA1Gy84kqmg2eDzQHaFj?rs=1&pid=ImgDetMain";
      }
      everyArticles.add(ArticleModel.fromJson(everythingResp["articles"][i]));
    }

    return everyArticles;
  }

   Future<List<ArticleModel>> getAllArticls(
      {String query = "business"}) async {
    dynamic everythingResp = await Api().get(
        url:
            "https://newsapi.org/v2/everything?q=$query&language=en&apiKey=$apiKey");

    List<ArticleModel> everyArticles = [];
    for (int i = 0; i < everythingResp["articles"].length; i++) {
      if (everythingResp["articles"][i]["title"] == "[Removed]") {
        continue;
      }
      if (everythingResp["articles"][i]["urlToImage"] == null) {
        everythingResp["articles"][i]["urlToImage"] =
            "https://th.bing.com/th/id/OIP.NPpdGIpA1Gy84kqmg2eDzQHaFj?rs=1&pid=ImgDetMain";
      }
      everyArticles.add(ArticleModel.fromJson(everythingResp["articles"][i]));
    }

    return everyArticles;
  }
}
