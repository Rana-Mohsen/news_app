import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/cubits/home_categorys/home_categorys_cubit.dart';
import 'package:news_app/models/everything_model.dart';
import 'package:news_app/screens/search_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    var topHeight = MediaQuery.of(context).viewPadding.top;
    return BlocProvider(
      create: (context) => HomeCategorysCubit(),
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: topHeight * 2.0, bottom: topHeight),
                  child: textFieldContainer(const SearchScreen()),
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
            Expanded(
              child: SingleChildScrollView(
               // dragStartBehavior: DragStartBehavior.down,
                child: Column(
                  children: [
                    FutureBuilder<List<ArticleModel>>(
                      future: AllArticles().getCtgArticls(keyWord: "general"),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('No articles found');
                        } else {
                          return _slider(snapshot.data!);
                        }
                      },
                    ),
                    const CustomChoiceChip(),
                    BlocBuilder<HomeCategorysCubit, HomeCategorysState>(
                      builder: (context, state) {
                        String ctg =
                            BlocProvider.of<HomeCategorysCubit>(context)
                                .category;

                        return FutureBuilder<List<ArticleModel>>(
                          future: AllArticles().getCtgArticls(keyWord: ctg),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Text('No articles found');
                            } else {
                              return _categoryList(snapshot.data!);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textFieldContainer(Widget route) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => route,
          )),
      child: Container(
        width: 80.w,
        height: 6.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 12.0),
              child: Text(
                "Search News",
                style: TextStyle(color: Colors.grey.shade400),
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.only(end: 12.0),
              child: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
          ],
        ),
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

  Widget _categoryList(List<ArticleModel> articles) {
    return SizedBox(
      height: 74.h,
      child: ListView.builder(
       // physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: 10,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 150.0,
            child: CategorySlide(
              article: articles[index],
            ),
          );
        },
      ),
    );
  }
}
