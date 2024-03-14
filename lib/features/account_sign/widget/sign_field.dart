import 'package:book_library/common/src/constants/colors.dart';
import 'package:flutter/material.dart';

class SignField extends StatelessWidget {
  const SignField({
    super.key,
    this.controller,
    required this.lable,
    this.lableStyle,
    this.validator,
    this.keyboardType,
  });

  final TextEditingController? controller;
  final String lable;
  final TextStyle? lableStyle;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.bg2, // Background color
        hintText: lable,
        hintStyle: lableStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // Border radius
          borderSide: BorderSide.none, // Remove border side
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
