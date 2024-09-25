import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/search/search_cubit.dart';
import 'package:news_app/models/everything_model.dart';
import 'package:news_app/screens/widgets/category_slide.dart';
import 'package:news_app/screens/widgets/custome_textfield.dart';
import 'package:news_app/services/get_articles.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          SizedBox(
            height: 5.h,
          ),
          CustomeTextField(
            onChanged: (para) {
              query = para;
              BlocProvider.of<SearchCubit>(context).searchBody(para);
            },
            iconPressed: () {
              Navigator.pop(context);
            },
            hintText: "Search",
          ),
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchResult) {
                return FutureBuilder<List<ArticleModel>>(
                  future: AllArticles().getAllArticls(query: query!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No articles found');
                    } else {
                      return _categoryList(snapshot.data!);
                    }
                  },
                );
              } else {
                return const Text("");
              }
            },
          ),
        ]),
      ),
    );
  }

  Widget _categoryList(List<ArticleModel> articles) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: articles.length,
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
