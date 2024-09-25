import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/cubits/favorit/favorit_cubit.dart';
import 'package:news_app/models/everything_model.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails({super.key, required this.article});
  final ArticleModel article;

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<FavoritCubit>(context);
    bool isFav = widget.article.isFav;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isFav = !isFav;
            isFav
                ? bloc.addFavorit(widget.article)
                : bloc.removeFavorit(widget.article);
            BlocProvider.of<FavoritCubit>(context).favoritBody();
          });
        },
        backgroundColor: kPrimaryColor,
        shape: const CircleBorder(),
        child: Icon(
          isFav ? Icons.favorite : Icons.favorite_border,
          color: Colors.white,
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            child: SizedBox(
              height: 50.h,
              width: 100.w,
              child: Image.network(
                widget.article.urlToImage!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 5.h,
            left: 5.w,
            child: customBackIcon(context),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: contentContainer(),
          ),
          Positioned(
            bottom: 52.8.h - 10.h,
            left: 10.w,
            child: headerContainer(),
          ),
        ],
      ),
    );
  }

  Widget customBackIcon(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffc4bbc0),
          borderRadius: BorderRadius.circular(13),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
    );
  }

  Widget headerContainer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 35.0, sigmaY: 35.0),
        child: Container(
          height: 20.h,
          width: 80.w,
          decoration: BoxDecoration(
            color: const Color(0xffF5F5F5).withOpacity(0.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.article.publishedAt!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  widget.article.title ?? 'none',
                  style: const TextStyle(
                    fontFamily: "Libre",
                  ),
                ),
                Text(
                  widget.article.author ?? "unknown",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget contentContainer() {
    return Container(
      //alignment: Alignment.bottomCenter,
      height: 52.8.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 96, left: 16, right: 16),
        child: Column(
          children: [
            Text(
              widget.article.content ?? "none",
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.menu_book,
                  color: kPrimaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    child: const Text(
                      "Tap to read more",
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () async {
                      Uri url = Uri.parse(widget.article.url!);
                      await launchUrl(url);

                      // if (await canLaunchUrl(url)) {
                      //   await launchUrl(url);
                      // }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
