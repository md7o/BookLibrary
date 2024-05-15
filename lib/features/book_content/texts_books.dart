import 'dart:async';

import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/books_content_provider.dart';
import 'package:book_library/common/provider/categories_provider/book_mark_provider.dart';
import 'package:book_library/common/provider/categories_provider/book_theme_provider.dart';
import 'package:book_library/common/provider/categories_provider/screen_time_provider.dart';
import 'package:book_library/common/provider/categories_provider/text_type_provider.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/features/profile/categories_pages/book_theme.dart';
import 'package:book_library/features/profile/categories_pages/font_style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tuple/tuple.dart';

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
  int currentIndex = 0;

  bool eyeShow = true;

  CarouselController carouselController = CarouselController();

  final String longText =
      "In a quaint little village nestled amidst rolling hills,there stood a cozy teahouse known as The Whispering Brew. Its wooden beams were weathered, and its windows adorned with lace curtains that swayed gently in the breeze. Inside, the aroma of freshly brewed tea danced in the air, inviting weary travelers and curious locals alike to step inside and indulge in a moment of tranquility.At the heart of the teahouse sat an old oak table, where an eclectic group of patrons gathered each afternoon. There was Mrs. Abernathy, the wise elder of the village, who sipped her Earl Grey with a knowing smile. Next to her sat young Timothy, an aspiring poet who found inspiration in the swirls of steam rising from his cup. And then there was Isabella, the enigmatic newcomer with a penchant for green tea and mysterious tales.One chilly afternoon, as rain pattered against the windows, a stranger walked into The Whispering Brew. His name was Elias, and he carried with him an air of quiet curiosity. He settled at the table and ordered a cup of chamomile, his eyes wandering over the faces of the other patrons with intrigue.As the hours passed and the rain continued to fall, the conversations around the table grew lively. Tales were spun, laughter echoed through the teahouse, and bonds were formed over shared cups of tea. And amidst it all, Elias listened intently, his own story yet to unfold. In a quaint little village nestled amidst rolling hills, there stood a cozy teahouse known as The Whispering Brew. Its wooden beams were weathered, and its windows adorned with lace curtains that swayed gently in the breeze. Inside, the aroma of freshly brewed tea danced in the air, inviting weary travelers and curious locals alike to step inside and indulge in a moment of tranquility.At the heart of the teahouse sat an old oak table, where an eclectic group of patrons gathered each afternoon. There was Mrs. Abernathy, the wise elder of the village, who sipped her Earl Grey with a knowing smile. Next to her sat young Timothy, an aspiring poet who found inspiration in the swirls of steam rising from his cup. And then there was Isabella, the enigmatic newcomer with a penchant for green tea and mysterious tales.One chilly afternoon, as rain pattered against the windows, a stranger walked into The Whispering Brew. His name was Elias, and he carried with him an air of quiet curiosity. He settled at the table and ordered a cup of chamomile, his eyes wandering over the faces of the other patrons with intrigue.As the hours passed and the rain continued to fall, the conversations around the table grew lively. Tales were spun, laughter echoed through the teahouse, and bonds were formed over shared cups of tea. And amidst it all, Elias listened intently, his own story yet to unfold. In a quaint little village nestled amidst rolling hills, there stood a cozy teahouse known as The Whispering Brew. Its wooden beams were weathered, and its windows adorned with lace curtains that swayed gently in the breeze. Inside, the aroma of freshly brewed tea danced in the air, inviting weary travelers and curious locals alike to step inside and indulge in a moment of tranquility.At the heart of the teahouse sat an old oak table, where an eclectic group of patrons gathered each afternoon. There was Mrs. Abernathy, the wise elder of the village, who sipped her Earl Grey with a knowing smile. Next to her sat young Timothy, an aspiring poet who found inspiration in the swirls of steam rising from his cup. And then there was Isabella, the enigmatic newcomer with a penchant for green tea and mysterious tales.One chilly afternoon, as rain pattered against the windows, a stranger walked into The Whispering Brew. His name was Elias, and he carried with him an air of quiet curiosity. He settled at the table and ordered a cup of chamomile, his eyes wandering over the faces of the other patrons with intrigue.As the hours passed and the rain continued to fall, the conversations around the table grew lively. Tales were spun, laughter echoed through the teahouse, and bonds were formed over shared cups of tea. And amidst it all, Elias listened intently, his own story yet to unfold.";
  List<String> slides = [];

  List<String> splitTextIntoChunks(String text, int maxCharsPerSlide) {
    List<String> chunks = [];

    List<String> words = text.split(' ');
    String currentChunk = '';

    for (int i = 0; i < words.length; i++) {
      String word = words[i];

      if ((currentChunk.length + word.length) <= maxCharsPerSlide) {
        currentChunk += (currentChunk.isEmpty ? '' : ' ') + word;
      } else {
        chunks.add(currentChunk);
        currentChunk = word;
      }

      if (i == words.length - 1) {
        chunks.add(currentChunk);
      }
    }

    return chunks;
  }

  final items = ['FontSize', 'Background Color'];
  String? selectedValue = 'FontSize';

  void _navigateToCategoryPage(String category) {
    switch (category) {
      case 'FontSize':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EditFont()),
        );
        break;
      case 'Background Color':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookTheme()),
        );
        break;
      // Add cases for more categories if needed
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // int maxCharsPerSlide = (MediaQuery.of(context).size.height < 700.0 ? 600.0 : MediaQuery.of(context).size.height * 1.3).round();
    final fontSizeBox = Hive.box('saveBox');
    final double increaseFontSize = fontSizeBox.get('fontSize', defaultValue: 16.0);
    double height = MediaQuery.of(context).size.height;
    int maxCharsPerSlide = 0;

    if (height < 700.0) {
      maxCharsPerSlide = 600;
    } else if (height >= 700.0 && height <= 820.0) {
      maxCharsPerSlide = 1000;
    } else if (height > 820.0 && height < 1000.0) {
      maxCharsPerSlide = 1200;
    } else {
      maxCharsPerSlide = (height * 2).round();
    }

    maxCharsPerSlide = maxCharsPerSlide.round();
// for Increase text size
    if (increaseFontSize >= 18.0 && increaseFontSize <= 20.0) {
      height < 700.0 ? maxCharsPerSlide = 500 : maxCharsPerSlide = 650;
      height >= 700.0 && height < 1000.0 ? maxCharsPerSlide = 650 : maxCharsPerSlide = 2000;
    } else if (increaseFontSize >= 22.0 && increaseFontSize <= 24.0) {
      height < 700.0 ? maxCharsPerSlide = 1500 : maxCharsPerSlide = 1500;
      height >= 700.0 && height < 1000.0 ? maxCharsPerSlide = 800 : maxCharsPerSlide = 800;
    }

    List<String> textChunks = splitTextIntoChunks(longText, maxCharsPerSlide);

    final booksData = ref.watch(booksContentProvider);

    // final isBookmarked = ref.watch(BookMarkProvider(currentIndex).notifier).state;
    final fontType = ref.watch(fontTypeProvider);
    final pageTheme = ref.watch(containerColorProvider);
    final textColorLuminance = pageTheme.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notifier = ref.read(containerColorProvider.notifier);
      await notifier.loadSavedColor();
    });

    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: pageTheme,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Column(
          children: [
            if (eyeShow)
              (IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  color: textColorLuminance,
                  size: 30,
                ),
              )),
          ],
        ),
        actions: [
          if (eyeShow)
            DropdownButton(
              hint: Text(
                'Options',
                style: TextStyle(color: textColorLuminance, fontSize: 20),
              ),
              style: TextStyle(color: textColorLuminance, fontSize: 20),
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                  _navigateToCategoryPage(newValue);
                });
              },
              items: items
                  .map(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )
                  .toList(),

              borderRadius: BorderRadius.circular(10.0),
              icon: Icon(Icons.keyboard_arrow_down), // Dropdown icon
              iconSize: 24.0, // Dropdown icon size
              iconEnabledColor: AppColors.primary, // Dropdown icon color

              underline: const SizedBox(),
              padding: const EdgeInsets.all(5), // Remove underline
            )

          // if (eyeShow)
          //   InkWell(
          //     onTap: () {
          //       Navigator.of(context).push(
          //         MaterialPageRoute(
          //           builder: (context) => const EditFont(),
          //         ),
          //       );
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.only(right: 15),
          //       child: Text(
          //         "FontSize: $increaseFontSize",
          //         style: TextStyle(
          //           fontSize: 16,
          //           color: textColorLuminance,
          //           decoration: TextDecoration.underline,
          //           decorationColor: textColorLuminance,
          //           decorationThickness: 1.5,
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                enableInfiniteScroll: false,
                scrollPhysics: const PageScrollPhysics(),
                height: maxCharsPerSlide.toDouble(),
                viewportFraction: 1.0,
              ),
              items: textChunks.asMap().entries.map((entry) {
                final currentIndex = entry.key;
                final text = entry.value;
                // final isBookmarked = ref.watch(BookMarkProvider(widget.character.pages!).notifier).state;
                final isBookmarked = ref.watch(bookMarkProvider(Tuple3(false, currentIndex, widget.character.pages!)).notifier);
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (currentIndex == 0) // Only display title on first page
                            Text(
                              widget.character.title!,
                              style: TextStyle(
                                color: textColorLuminance,
                                fontSize: 25,
                              ),
                            ),
                          Expanded(
                            child: Center(
                              child: RawScrollbar(
                                thumbColor: textColorLuminance,
                                trackColor: Color(0xFF898989),
                                trackVisibility: true,
                                thumbVisibility: true,
                                radius: const Radius.circular(50),
                                thickness: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Container(
                                    // height: 600,
                                    alignment: Alignment.center,
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Text(
                                        text,
                                        style: GoogleFonts.getFont(
                                          _getSelectedFont(fontType),
                                          fontSize: increaseFontSize,
                                          color: textColorLuminance,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: eyeShow
                                      ? Icon(
                                          Icons.remove_red_eye,
                                          color: textColorLuminance,
                                          size: 25,
                                        )
                                      : Icon(
                                          Icons.remove_red_eye_outlined,
                                          color: textColorLuminance,
                                          size: 25,
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      eyeShow = !eyeShow;
                                    });
                                  },
                                ),
                                Text(
                                  "${currentIndex + 1}",
                                  style: TextStyle(
                                    color: textColorLuminance,
                                    fontSize: 20,
                                  ),
                                ),
                                if (eyeShow)
                                  InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      // ref.read(bookMarkProvider(widget.character.pages!).notifier).state = !isBookmarked;
                                      ref.read(bookMarkProvider(Tuple3(false, currentIndex, widget.character.pages!)).notifier).state =
                                          !isBookmarked.state;
                                    },
                                    child: Row(
                                      children: [
                                        isBookmarked.state
                                            ? const Icon(
                                                Icons.bookmark,
                                                size: 30,
                                                color: Colors.red,
                                              )
                                            : Icon(
                                                Icons.bookmark_outline,
                                                color: textColorLuminance,
                                                size: 30,
                                              ),
                                        Text(
                                          "Mark",
                                          style: TextStyle(
                                            color: textColorLuminance,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  int _seconds = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        ref.read(screenTimeProvider.notifier).state = _convertSecondsToScreenTime(_seconds);
      });
    });
  }

  ClockNumbers _convertSecondsToScreenTime(int seconds) {
    int hours = seconds ~/ 3600;
    seconds %= 3600;
    int minutes = seconds ~/ 60;
    seconds %= 60;
    return ClockNumbers(hours: hours, minutes: minutes, seconds: seconds);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _getSelectedFont(int fontIndex) {
    switch (fontIndex) {
      case 0:
        return 'Rubik';
      case 1:
        return 'Comfortaa';
      case 2:
        return 'Ubuntu';
      default:
        return 'Rubik';
    }
  }
}
