import 'package:book_library/common/provider/book_theme_provider.dart';
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
      'color': Color.fromARGB(255, 240, 219, 184),
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
    // final textColorLuminance = buttons[index]['color'].computeLuminance() > 0.5 ? AppColors.bg2 : Colors.white;

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
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: buttons[index]['color'],
                  borderRadius: BorderRadius.circular(25),
                ),
                // maxRadius: maxRadius,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Aa',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: buttons[index]['color'].computeLuminance() > 0.5 ? AppColors.bg2 : Colors.white),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          buttons[index]['label'],
                          style: TextStyle(color: buttons[index]['color'].computeLuminance() > 0.5 ? AppColors.bg2 : Colors.white),
                        ),
                      ],
                    ),
                    AnimatedSwitcher(
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
                          : const SizedBox.shrink(),
                    ),
                  ],
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

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.large,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.bg2,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppPadding.large,
          ),
          child: Column(
            children: [
              buildButtonRow(0, 3),
              const SizedBox(height: 10),
              buildButtonRow(3, 6),
              // Add more rows as needed
            ],
          ),
        ),
      ),
    );
  }
}
