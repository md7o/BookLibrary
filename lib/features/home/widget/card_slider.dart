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
      'text': 'Correct typos in the text',
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
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Expanded(
              child: Container(
                width: 160,
                decoration: BoxDecoration(
                  color: Color(0x96151515),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      items[index]["imageUrl"],
                      scale: 8,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        items[index]["text"],
                        style: const TextStyle(fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
