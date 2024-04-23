import 'package:book_library/common/provider/categories_provider/book_theme_provider.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/common/src/wallpaper/animation_wall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookTheme extends ConsumerStatefulWidget {
  const BookTheme({super.key});

  @override
  ConsumerState<BookTheme> createState() => _BookThemeState();
}

class _BookThemeState extends ConsumerState<BookTheme> {
  List<Map<String, dynamic>> buttons = [
    {
      'color': Colors.white,
      'isSelected': false,
      'label': 'White',
    },
    {
      'color': AppColors.bg1,
      'isSelected': false,
      'label': 'Black',
    },
    {
      'color': const Color(0xFFFFF9E3),
      'isSelected': false,
      'label': 'Moccasin',
    },
    {
      'color': const Color(0xFFE9E6FF),
      'isSelected': false,
      'label': 'Lavender',
    },
    {
      'color': const Color(0xFFE2FFE9),
      'isSelected': false,
      'label': 'Green',
    },
    {
      'color': const Color(0xFFDEF9FF),
      'isSelected': false,
      'label': 'Blue',
    },
  ];
  bool isSelected = true;
  @override
  Widget build(BuildContext context) {
    final pageTheme = ref.watch(containerColorProvider);
    final textColorLuminance = pageTheme.computeLuminance() > 0.5 ? AppColors.bg2 : Colors.white;

    final fontSizeBox = Hive.box('saveBox');
    final fontSize = fontSizeBox.get('fontSize', defaultValue: 16.0);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final notifier = ref.read(containerColorProvider.notifier);
        await notifier.loadSavedColor();
      },
    );

    GestureDetector buildButton(int index, double maxRadius) {
      return GestureDetector(
        onTap: () {
          ref.read(containerColorProvider.notifier).changeColor(buttons[index]['color']);
          setState(() {
            for (var button in buttons) {
              button['isSelected'] = false;
            }
            buttons[index]['isSelected'] = true;
          });
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border:
                    buttons[index]['isSelected'] ? Border.all(color: AppColors.primary, width: 5) : Border.all(width: 5, color: Colors.transparent),
                borderRadius: BorderRadius.circular(100),
              ),
              child: CircleAvatar(
                backgroundColor: buttons[index]['color'],
                maxRadius: maxRadius,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 1200),
                  reverseDuration: const Duration(milliseconds: 100),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                  switchInCurve: Curves.elasticOut,
                  switchOutCurve: Curves.linear,
                  child: buttons[index]['isSelected']
                      ? const Icon(
                          Icons.check_rounded,
                          size: 50,
                          color: AppColors.primary,
                        )
                      : const SizedBox.shrink(), // Use SizedBox.shrink() to indicate no child when not selected
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              buttons[index]['label'],
              style: const TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      );
    }

    Widget buildButtonRow(int startIndex, int endIndex) {
      double maxRadius = MediaQuery.of(context).size.height * 0.04; // Adjust as needed
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons.sublist(startIndex, endIndex).asMap().entries.map((entry) {
          return buildButton(entry.key + startIndex, maxRadius);
        }).toList(),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.bg1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Book Theme'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const AnimationWall(),
          Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                          left: 20,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 30,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: AppColors.primary,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Icon(Icons.book),
                                SizedBox(width: 5),
                                Text(
                                  "Book Preview",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppPadding.large,
                              right: 20,
                              left: 20,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                color: pageTheme,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Text(
                                    "Mercedes-Benz, born from the 1926 merger of Karl Benz and Gottlieb Daimler's pioneering automotive companies, is renowned for luxury, innovation, and motorsport success. Continuously leading with cutting-edge technology and timeless elegance, it remains a symbol of automotive excellence.",
                                    style: TextStyle(fontSize: fontSize, color: textColorLuminance),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.large,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.bg2,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppPadding.large,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              buildButtonRow(0, 3), // Adjust the indices based on the number of buttons per row
                              const SizedBox(height: 10),
                              buildButtonRow(3, 6),
                              // Add more rows as needed
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
