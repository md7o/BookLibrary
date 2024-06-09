import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/book_theme_provider.dart';
import 'package:book_library/common/provider/customize_text_provider.dart';
import 'package:book_library/common/provider/text_type_provider.dart';
import 'package:book_library/features/book_content/Abbreviations/font_style_drag.dart';
import 'package:book_library/features/book_content/Abbreviations/if_condition_orders.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TextsBooks extends ConsumerStatefulWidget {
  const TextsBooks({
    super.key,
    required this.character,
  });

  final BooksModel character;
  @override
  ConsumerState<TextsBooks> createState() => _TextsBooksState();
}

class _TextsBooksState extends ConsumerState<TextsBooks> {
  bool _showEdgesScreen = true;

  CarouselController carouselController = CarouselController();

  List<String> slides = [];

  List<String> splitTextIntoChunks(String text, int maxWordPerSlide) {
    List<String> chunks = [];
    List<String> words = text.split(' ');

    StringBuffer currentChunk = StringBuffer();
    int currentLength = 0;

    for (String word in words) {
      if ((currentLength + word.length + 1) <= maxWordPerSlide) {
        // +1 for the space after each word
        if (currentChunk.isNotEmpty) {
          currentChunk.write(' ');
          currentLength++;
        }
        currentChunk.write(word);
        currentLength += word.length;
      } else {
        chunks.add(currentChunk.toString());
        currentChunk.clear();
        currentChunk.write(word);
        currentLength = word.length;
      }
    }

    if (currentChunk.isNotEmpty) {
      chunks.add(currentChunk.toString());
    }

    return chunks;
  }

  final items = ['FontSize', 'Background Color'];
  String? selectedValue = 'FontSize';

  @override
  Widget build(BuildContext context) {
    // int maxWordsInSlide = (MediaQuery.of(context).size.height < 700.0 ? 600.0 : MediaQuery.of(context).size.height * 1.3).round();
    final fontSizeBox = Hive.box('saveBox');
    final double increaseFontSize = fontSizeBox.get('fontSize', defaultValue: 16.0);
    double height = MediaQuery.of(context).size.height;
    // int maxWordsInSlide = 0;

    int maxWordsInSlide = calculateMaxWordsInSlide(height, increaseFontSize);

    List<String> textChunks = splitTextIntoChunks(widget.character.pages!, maxWordsInSlide);

    final isBold = ref.watch(isBoldProvider);
    final isJustify = ref.watch(isJustifyProvider);

    final fontType = ref.watch(fontTypeProvider);
    final pageTheme = ref.watch(containerColorProvider);
    final textColorLuminance = pageTheme.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notifier = ref.read(containerColorProvider.notifier);
      await notifier.loadSavedColor();
    });

    return Scaffold(
      backgroundColor: pageTheme,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _showEdgesScreen
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: textColorLuminance,
                    size: 32,
                  ),
                )
              : SizedBox(),
        ),
        actions: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: _showEdgesScreen
                ? IconButton(
                    onPressed: openThemAndSetting,
                    icon: Icon(
                      Icons.tune_rounded,
                      color: textColorLuminance,
                      size: 32,
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _showEdgesScreen = !_showEdgesScreen;
            });
          },
          child: CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: false,
              scrollPhysics: const PageScrollPhysics(),
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1.0,
            ),
            items: textChunks.asMap().entries.map((entry) {
              final currentIndex = entry.key;
              final story = entry.value;

              final box = Hive.box('saveBox');
              final key = 'bookmark_${widget.character.id}_$currentIndex';
              var isBookmarked = box.get(key, defaultValue: false);

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentIndex == 0)
                    Text(
                      widget.character.title!,
                      style: TextStyle(
                        color: textColorLuminance,
                        fontSize: 25,
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Text(
                            story,
                            style: GoogleFonts.getFont(
                              _getSelectedFont(fontType),
                              fontSize: increaseFontSize,
                              color: textColorLuminance,
                              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                            ),
                            textAlign: isJustify ? TextAlign.justify : TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20), // Adjusted horizontal padding
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${currentIndex + 1}",
                          style: TextStyle(
                            color: _showEdgesScreen ? textColorLuminance : Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                        GestureDetector(
                            key: const Key('bookmark'),
                            onTap: () {
                              final newValue = !isBookmarked;
                              box.put(key, newValue);
                              setState(() {
                                isBookmarked = newValue;
                              });
                            },
                            child: isBookmarked
                                ? Icon(Icons.bookmark, size: 28, color: _showEdgesScreen ? Colors.red : Colors.transparent)
                                : Icon(
                                    Icons.bookmark_outline,
                                    color: _showEdgesScreen ? textColorLuminance : Colors.transparent,
                                    size: 28,
                                  ))
                      ],
                    ),
                  )
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void openThemAndSetting() {
    showModalBottomSheet(
      backgroundColor: const Color(0x8F000000),
      context: context,
      isScrollControlled: false,
      showDragHandle: true,
      builder: (BuildContext context) => const SizedBox(height: 400, child: FontStyleDrag()),
    );
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
}
