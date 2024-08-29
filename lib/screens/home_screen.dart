import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/screens/widgets/custome_textfield.dart';

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
            ],
          )
        ],
      ),
    );
  }
}
