import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LastNewsSlide extends StatelessWidget {
  const LastNewsSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      // width: 80.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage("images/rec.png"),
            fit: BoxFit.cover,
          )),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "by Ryan Browne",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "Crypto investors should be prepared to lose all their money, BOE governor says",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
