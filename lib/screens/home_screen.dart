import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/screens/widgets/custom_choice_chip.dart';
import 'package:news_app/screens/widgets/custome_textfield.dart';
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
          _slider(),
          CustomChoiceChip(),
          _categoryList(),
        ],
      ),
    );
  }

  Widget _slider() {
    return CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return SizedBox(
          width: 100.w,
          child: Image.network(
            "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
            fit: BoxFit.cover,
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
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
            width: 350.0, // Set a specific width
            height: 150.0, // Set a specific height
            child: Image.network(
              "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
              fit: BoxFit.cover,
            ),
          );
          ;
        },
      ),
    );
  }
}
