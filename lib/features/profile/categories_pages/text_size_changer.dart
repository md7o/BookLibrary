import 'package:book_library/common/provider/categories_provider/text_size_provider.dart';
import 'package:book_library/common/provider/categories_provider/text_type_provider.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/common/src/wallpaper/animation_wall.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TextSizeChanger extends ConsumerStatefulWidget {
  const TextSizeChanger({super.key});

  @override
  ConsumerState<TextSizeChanger> createState() => _TextSizeChangerState();
}

class FontIndexNotifier extends StateNotifier<int> {
  FontIndexNotifier() : super(0);

  void setFontIndex(int index) {
    state = index;
  }
}

class _TextSizeChangerState extends ConsumerState<TextSizeChanger> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final fontSize = ref.watch(fontSizeProvider);
    final fontType = ref.watch(fontTypeProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          const AnimationWall(),
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.large, vertical: 50),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.bg2,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Mercedes-Benz, born from the 1926 merger of Karl Benz and Gottlieb Daimler's pioneering automotive companies, is renowned for luxury, innovation, and motorsport success. Continuously leading with cutting-edge technology and timeless elegance, it remains a symbol of automotive excellence.",
                      style: GoogleFonts.getFont(
                        _getSelectedFont(fontType),
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
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
                        padding: const EdgeInsets.all(AppPadding.large),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.text_fields_rounded,
                                      color: AppColors.primary,
                                      size: 30,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Font Size",
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  for (int i = 16; i < 25; i += 2)
                                    Text(
                                      "$i",
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: _getTextColor(fontSize, i.toDouble()),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 13),
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  overlayShape: SliderComponentShape.noOverlay,
                                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                                  thumbColor: AppColors.primary,
                                  activeTrackColor: AppColors.primary,
                                  tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 4),
                                  activeTickMarkColor: const Color(0xFF55DB9A),
                                  inactiveTickMarkColor: const Color(0xFF24322A),
                                  inactiveTrackColor: const Color(0xFF24322A),
                                ),
                                child: Slider(
                                  value: fontSize,
                                  min: 16.0,
                                  max: 24.0,
                                  divisions: 4,

                                  onChanged: (newValue) {
                                    ref.read(fontSizeProvider.notifier).state = newValue;
                                    _saveFontSize(newValue);
                                  },
                                  // label: "${fontSizeChanger.round()}",
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.font_download_rounded,
                                        color: AppColors.primary,
                                        size: 30,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Font Type",
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        ref.read(fontTypeProvider.notifier).state = 0;
                                        _saveFontType(0);
                                      },
                                      child: Text(
                                        'Cairo',
                                        style: GoogleFonts.cairo(fontSize: 20, color: fontType == 0 ? AppColors.primary : const Color(0x556D937C)),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        ref.read(fontTypeProvider.notifier).state = 1;
                                        _saveFontType(1);
                                      },
                                      child: Text(
                                        'Open Sans',
                                        style: GoogleFonts.openSans(fontSize: 20, color: fontType == 1 ? AppColors.primary : const Color(0x556D937C)),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        ref.read(fontTypeProvider.notifier).state = 2;
                                        _saveFontType(2);
                                      },
                                      child: Text(
                                        'Montserrat',
                                        style:
                                            GoogleFonts.montserrat(fontSize: 20, color: fontType == 2 ? AppColors.primary : const Color(0x556D937C)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getTextColor(double fontSizeChanger, double targetValue) {
    // Check if the slider value matches the target value
    if (fontSizeChanger == targetValue) {
      // Change color based on target value
      switch (targetValue.toInt()) {
        case 20:
          return AppColors.primary; // Change to red for 20
        default:
          return AppColors.primary; // Default color
      }
    } else {
      return const Color(0x556D937C);
    }
  }

  String _getSelectedFont(int fontIndex) {
    switch (fontIndex) {
      case 0:
        return 'Cairo';
      case 1:
        return 'Open Sans';
      case 2:
        return 'Montserrat';
      default:
        return 'Roboto';
    }
  }

  Future<void> _saveFontSize(double fontSize) async {
    final box = await Hive.openBox('saveBox');
    await box.put('fontSize', fontSize);
    ref.read(fontSizeProvider.notifier).state = fontSize; // Update font size immediately
  }

  Future<void> _saveFontType(int fontType) async {
    final box = await Hive.openBox('saveBox');
    await box.put('fontType', fontType);
    ref.read(fontTypeProvider.notifier).state = fontType; // Update font type immediately
  }
}
