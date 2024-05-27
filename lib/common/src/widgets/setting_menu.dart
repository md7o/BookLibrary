import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingMenu extends StatelessWidget {
  const SettingMenu({super.key, this.settingIcon, required this.onTapButton, required this.title, this.titleStyle});
  final VoidCallback? onTapButton;
  final String title;
  final TextStyle? titleStyle;
  final IconData? settingIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTapButton,
          child: Container(
            width: 250,
            height: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color(0xFF3E3E3E)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: titleStyle,
                  ),
                  Icon(settingIcon)
                  //  Icon(
                  //   Icons.settings,
                  //   size: 25,
                  // ),
                ],
              ),
            ),
          ),
        ),
        // const SizedBox(height: 10),
        // Container(
        //   width: 250,
        //   height: 40,
        //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color(0xFF3E3E3E)),
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 10),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         const Text(
        //           'Mark Book',
        //           style: TextStyle(fontSize: 20),
        //         ),
        //         Icon(settingIcon)
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
