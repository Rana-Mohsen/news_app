
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/favorit/favorit_cubit.dart';
import 'package:news_app/models/everything_model.dart';
import 'package:news_app/screens/widgets/category_slide.dart';
import 'package:sizer/sizer.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<FavoritCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite News"),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoritCubit, FavoritState>(
        builder: (context, state) {
          if (state is ShowFavorits) {
            return _categoryList(bloc.favArticles);
          } else {
            return const Center(
              child: Text("No favorite articles yet"),
            );
          }
        },
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
