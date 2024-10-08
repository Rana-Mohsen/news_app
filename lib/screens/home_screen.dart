import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/cubits/home_categorys/home_categorys_cubit.dart';
import 'package:news_app/models/everything_model.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/screens/widgets/category_slide.dart';
import 'package:news_app/screens/widgets/custom_choice_chip.dart';
import 'package:news_app/screens/widgets/last_news_slide.dart';
import 'package:news_app/services/get_articles.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isListViewScrollable = ValueNotifier(false);

  _controllScroll() {
    if (_scrollController.offset >= 200) {
      // Adjust this value as needed
      _isListViewScrollable.value = true;
    } else {
      _isListViewScrollable.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_controllScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_controllScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var topHeight = MediaQuery.of(context).viewPadding.top;
    return BlocProvider(
      create: (context) => HomeCategorysCubit(),
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: topHeight * 2.0, bottom: topHeight),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textFieldContainer(const SearchScreen()),
                  const CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 16),
                      child: Text(
                        "Latest News",
                        style: TextStyle(
                          fontFamily: "Libre",
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                    FutureBuilder<List<ArticleModel>>(
                      future: AllArticles().getCtgArticls(keyWord: "general"),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return shimmerSlide();
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
                              return shimmerList();
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
        child: ValueListenableBuilder<bool>(
            valueListenable: _isListViewScrollable,
            builder: (context, isScrollable, child) {
              return ListView.builder(
                physics: isScrollable
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                //shrinkWrap: true,
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
              );
            }));
  }

  Widget shimmerSlide() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!,
        child: Center(
          child: Container(
            height: 200,
            width: 80.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ));
  }

  Widget shimmerList() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ));
  }
}
