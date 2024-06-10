import 'package:book_library/common/src/constants/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CardSlider extends StatefulWidget {
  const CardSlider({super.key});

  @override
  State<CardSlider> createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  final List<Map<String, dynamic>> items = [
    {
      'imageUrl': 'assets/images/ai.png',
      'text': 'Take the book content from AI',
    },
    {
      'imageUrl': 'assets/images/checked.png',
      'text': 'Corrected some spelling errors',
    },
    {
      'imageUrl': 'assets/images/note.png',
      'text': 'Text formulation',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: MediaQuery.of(context).size.width > 360 ? 170 : 140,
              decoration: BoxDecoration(
                color: const Color(0x96151515),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    items[index]["imageUrl"],
                    scale: MediaQuery.of(context).size.width > 360 ? 8 : 11,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      items[index]["text"],
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width > 360 ? 17 : 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
