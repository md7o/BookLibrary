import 'package:book_library/common/provider/book_theme_provider.dart';
import 'package:book_library/common/provider/customize_text_provider.dart';
import 'package:book_library/common/provider/text_size_provider.dart';
import 'package:book_library/common/provider/text_type_provider.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/common/src/wallpaper/animation_wall.dart';
import 'package:book_library/features/setting/categories_pages/book_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditFont extends ConsumerStatefulWidget {
  const EditFont({super.key});

  @override
  ConsumerState<EditFont> createState() => _EditFontState();
}

class FontIndexNotifier extends StateNotifier<int> {
  FontIndexNotifier() : super(0);

  void setFontIndex(int index) {
    state = index;
  }
}

class _EditFontState extends ConsumerState<EditFont> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final fontSize = ref.watch(fontSizeProvider);
    final fontType = ref.watch(fontTypeProvider);

    final isBold = ref.watch(isBoldProvider);
    final isJustify = ref.watch(isJustifyProvider);

    final pageTheme = ref.watch(containerColorProvider);
    final textColorLuminance = pageTheme.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: AppColors.bg1,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        excludeHeaderSemantics: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Font'),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AnimationWall(),
          const SizedBox(height: 50),
          ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.xlarge),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Book Demo",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(color: pageTheme, borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Text(
                            "Mercedes-Benz, born from the 1926 merger of Karl Benz and Gottlieb Daimler's pioneering automotive companies, is renowned for luxury, innovation, and motorsport success. Continuously leading with cutting-edge technology and timeless elegance, it remains a symbol of automotive excellence.",
                            style: GoogleFonts.getFont(
                              color: textColorLuminance,
                              _getSelectedFont(fontType),
                              fontSize: fontSize,
                              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                            ),
                            textAlign: isJustify ? TextAlign.justify : TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Opacity(
                opacity: 0.4,
                child: Divider(
                  indent: 20,
                  endIndent: 20,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.xlarge, vertical: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Text",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.large),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.bg2,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: DropdownButton<int>(
                          icon: const Icon(Icons.arrow_forward_ios),
                          isExpanded: true,
                          value: fontType,
                          underline: const SizedBox(), // Remove the underline
                          items: [
                            DropdownMenuItem(
                              value: 0,
                              child: Text(
                                'Rubik',
                                style: GoogleFonts.rubik(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 1,
                              child: Text(
                                'Comfortaa',
                                style: GoogleFonts.comfortaa(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text(
                                'Ubuntu',
                                style: GoogleFonts.ubuntu(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text(
                                'Nunito',
                                style: GoogleFonts.nunito(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 4,
                              child: Text(
                                'Merriweather',
                                style: GoogleFonts.merriweather(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 5,
                              child: Text(
                                'Edu TAS Beginner ',
                                style: GoogleFonts.eduTasBeginner(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 6,
                              child: Text(
                                'Chakra Petch',
                                style: GoogleFonts.chakraPetch(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ],
                          onChanged: (int? newValue) {
                            if (newValue != null) {
                              ref.read(fontTypeProvider.notifier).state = newValue;
                              _saveFontType(newValue);
                            }
                          },
                          dropdownColor: const Color(0xFF333333),

                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.large),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.bg2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      "Aa",
                                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Bold Text",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: isBold,
                                  onChanged: (newValue) {
                                    setState(() {
                                      ref.read(isBoldProvider.notifier).toggleBold(newValue);
                                    });
                                  },
                                ),
                              ],
                            ),
                            const Opacity(
                              opacity: 0.4,
                              child: Divider(indent: 60),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.format_align_justify_rounded),
                                    SizedBox(width: 10),
                                    Text(
                                      "Justify Text",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: isJustify,
                                  onChanged: (newValue) {
                                    // Update the state when the switch is toggled
                                    setState(() {
                                      ref.read(isJustifyProvider.notifier).toggleBold(newValue);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.xlarge, vertical: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Book Theme Color",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const BookTheme(),
            ],
          ),
        ],
      ),
    );
  }

  Color _getTextColor(double fontSizeChanger, double targetValue) {
    if (fontSizeChanger == targetValue) {
      switch (targetValue.toInt()) {
        case 20:
          return AppColors.primary;
        default:
          return AppColors.primary;
      }
    } else {
      return const Color(0x556D937C);
    }
  }

  String _getSelectedFont(int fontIndex) {
    switch (fontIndex) {
      case 0:
        return 'Rubik';
      case 1:
        return 'Comfortaa';
      case 2:
        return 'Ubuntu';
      case 3:
        return 'Nunito';
      case 4:
        return 'Merriweather';
      case 5:
        return 'Edu TAS Beginner';
      case 6:
        return 'Chakra Petch';
      default:
        return 'Rubik';
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
