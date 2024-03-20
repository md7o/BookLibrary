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
    this.onSaved,
    required this.obscureText,
  });

  final TextEditingController? controller;
  final String lable;
  final TextStyle? lableStyle;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function(String?)? onSaved;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: const EdgeInsets.only(bottom: 1),
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: AppColors.bg2, // Background color
        hintText: lable,
        hintStyle: lableStyle,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // Border radius
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
