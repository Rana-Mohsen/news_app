import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CustomeTextField extends StatelessWidget {
  CustomeTextField(
      {super.key, this.hintText, this.iconPressed, this.onChanged});

  String? hintText;
  Function()? iconPressed;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 80.w,
      height: 6.h,
      child: TextField(
        // onTap: onTap,
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.bottom,
        cursorColor: Colors.black,
        cursorWidth: 0.4.w,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: iconPressed,
            icon: const Icon(Icons.close),
            color: Colors.black87,
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
