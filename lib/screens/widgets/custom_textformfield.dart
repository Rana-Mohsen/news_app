import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      this.hintText,
      required this.onChange,
      required this.validator,
      this.obscure = false,
      this.icon});

  String? hintText;
  Function(String) onChange;
  String? Function(String?)? validator;
  bool obscure;
  Widget? icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      validator: validator,
      onChanged: onChange,
      decoration: InputDecoration(
        suffixIcon: icon,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(
              color: Colors.black,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2)),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(32),
        //   borderSide: BorderSide(
        //     color: Colors.grey.shade300,
        //     width: 1.0,
        //   ),
        // ),
      ),
    );
  }
}
