import 'package:book_library/common/src/constants/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class InformationSlider extends StatefulWidget {
  const InformationSlider({super.key});

  @override
  State<InformationSlider> createState() => _InformationSliderState();
}

class _InformationSliderState extends State<InformationSlider> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> items = [
    {
      'imageUrl': 'assets/images/Coffee.png',
      'text': 'Knowledge: Books are rich sources of information and insights.',
    },
    {
      'imageUrl': 'assets/images/book.png',
      'text': 'Reading exercises your brain and sharpens cognitive skills.',
    },
    {
      'imageUrl': 'assets/images/phone.png',
      'text': 'you can carry a lot of books in your pocket',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: items.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                      gradient: const LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.primary,
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          item['imageUrl'],
                          scale: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            item['text'],
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            onPageChanged: (value, _) {
              setState(() {
                _currentIndex = value;
              });
            },
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 1500),
            autoPlayCurve: Curves.easeInOut,
            viewportFraction: 1,
            height: 150,
          ),
        ),
        const SizedBox(height: 10),
        buildCarsouselIndcator()
      ],
    );
  }

  buildCarsouselIndcator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++)
          Container(
            margin: const EdgeInsets.all(3),
            height: i == _currentIndex ? 9 : 7,
            width: i == _currentIndex ? 9 : 7,
            decoration: BoxDecoration(
              color: i == _currentIndex ? Colors.white : Colors.grey,
              shape: BoxShape.circle,
            ),
          )
      ],
    );
  }
}
