import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LastNewsSlide extends StatelessWidget {
  const LastNewsSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Image.asset(
            "images/rec.png",
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey.withOpacity(0.2),
                  Colors.grey.withOpacity(0.2),
                  Colors.black,
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
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
          ),
        ],
      ),
    );
  }
}
