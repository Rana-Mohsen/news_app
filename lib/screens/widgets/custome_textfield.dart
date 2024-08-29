import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CustomeTextField extends StatelessWidget {
  CustomeTextField({super.key, this.hintText, required this.onChange});

  String? hintText;
  Function(String) onChange;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 6.h,
      child: TextField(
        onChanged: onChange,
        textAlignVertical: TextAlignVertical.bottom,
        cursorColor: Colors.black,
        cursorWidth: 0.4.w,
        decoration: InputDecoration(
          suffixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: const BorderSide(
                color: Colors.black,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1.0,
              )),
        ),
      ),
    );
  }
}
