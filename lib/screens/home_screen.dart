import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/screens/widgets/custome_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _sliderIndex = 0;

  @override
  Widget build(BuildContext context) {
    var topHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: topHeight * 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomeTextField(
                hintText: "Search News",
                onChange: (p0) {},
              ),
              const CircleAvatar(
                backgroundColor: Color(kPrimaryColor),
                child: Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                ),
              ),
              _slider(),
            ],
          )
        ],
      ),
    );
  }

  Widget _slider() {
    return CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return Image.network("https://media.wired.com/photos/66ab594d0c0cc4819f595db4/191:100/w_1280,c_limit/073024_Crypto%20get%20rich%20quick.jpg");
      },
      options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
          aspectRatio: 2.0,
          initialPage: 0,
          onPageChanged: (index, reason) {
            _sliderIndex = index;
            setState(() {});
          }),
    );
  }
}
