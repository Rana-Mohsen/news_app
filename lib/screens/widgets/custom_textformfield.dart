import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';

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
        contentPadding: const EdgeInsets.all(16),
        suffixIcon: icon,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black87),
        errorStyle: const TextStyle(
          color: kTertiaryColor, // Change the color of the error message
          fontSize: 14, // Change the font size of the error message
          fontWeight:
              FontWeight.bold, // Change the font weight of the error message
        ),
        focusedBorder: _normalBorderStyle(color: Colors.black),
        enabledBorder: _normalBorderStyle(
          color: Colors.grey.shade300,
          width: 2,
        ),
        errorBorder: _errorBorderStyle(),
        focusedErrorBorder: _errorBorderStyle(),
      ),
    );
  }

  OutlineInputBorder _errorBorderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
      borderSide: const BorderSide(
        color: kTertiaryColor,
        width: 2,
      ),
    );
  }

  OutlineInputBorder _normalBorderStyle({required color, double width = 1}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: BorderSide(
          color: color,
          width: width,
        ));
  }
}
