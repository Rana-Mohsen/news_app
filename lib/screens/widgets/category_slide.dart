import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/everything_model.dart';
import 'package:news_app/services/get_articles.dart';
import 'package:sizer/sizer.dart';

class CategorySlide extends StatelessWidget {
  const CategorySlide({super.key, required this.article});
  final ArticleModel article;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Image.network(
            article.urlToImage ??
                "https://th.bing.com/th/id/OIP.NPpdGIpA1Gy84kqmg2eDzQHaFj?rs=1&pid=ImgDetMain",
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey.withOpacity(0.2),
                  Colors.grey.withOpacity(0.2),
                  Colors.black,
                ],
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? "none",
                    style: const TextStyle(color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 40.w,
                        child: Text(
                          article.author ?? "unknown",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Text(
                        article.publishedAt ?? " ",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
