import 'package:book_library/common/src/constants/colors.dart';
import 'package:flutter/material.dart';

class SignField extends StatefulWidget {
  const SignField({
    super.key,
    required this.lable,
    this.validator,
    this.keyboardType,
    this.onSaved,
    required this.obscureText,
    this.suffixIcon,
    this.onTap,
  });

  final String lable;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function(String?)? onSaved;
  final bool obscureText;
  final Widget? suffixIcon;
  final Function()? onTap;

  @override
  State<SignField> createState() => _SignFieldState();
}

class _SignFieldState extends State<SignField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: FocusNode(),
      scrollPadding: const EdgeInsets.only(bottom: 1),
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: AppColors.bg2, // Background color
        hintText: widget.lable,
        suffixIcon: widget.suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // Border radius
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onSaved: widget.onSaved,
      onTap: widget.onTap,
      readOnly: false,
    );
  }
}
