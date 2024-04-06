import 'package:book_library/common/src/constants/colors.dart';
import 'package:flutter/material.dart';

class CheckButton extends StatelessWidget {
  const CheckButton({super.key, this.onTap, required this.title});

  final VoidCallback? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
        ),
      ),
    );
  }
}
