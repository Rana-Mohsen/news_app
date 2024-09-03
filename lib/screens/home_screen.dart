import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/models/everything_model.dart';
import 'package:news_app/screens/widgets/category_slide.dart';
import 'package:news_app/screens/widgets/custom_choice_chip.dart';
import 'package:news_app/screens/widgets/custome_textfield.dart';
import 'package:news_app/screens/widgets/last_news_slide.dart';
import 'package:news_app/services/get_articles.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ArticleModel>> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = getArticles();
  }

  Future<List<ArticleModel>> getArticles() async {
    return await AllArticles().get_articls("celebrity");
  }

  @override
  Widget build(BuildContext context) {
    var topHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: topHeight * 2.0, bottom: topHeight),
                child: CustomeTextField(
                  hintText: "Search News",
                  onChange: (p0) {},
                ),
              ),
              const CircleAvatar(
                backgroundColor: Color(kPrimaryColor),
                child: Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          FutureBuilder<List<ArticleModel>>(
            future: futureArticles,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No articles found');
              } else {
                return _slider(snapshot.data!);
              }
            },
          ),
          CustomChoiceChip(),
          _categoryList(),
        ],
      ),
    );
  }

  Widget _slider(List<ArticleModel> articles) {
    return CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return LastNewsSlide(
          article: articles[itemIndex],
        );
      },
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.82,
        enableInfiniteScroll: false,
        initialPage: 0,
      ),
    );
  }

  Widget _categoryList() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: 5,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 150.0,
            child: CategorySlide(),
          );
        },
      ),
    );
  }
}
