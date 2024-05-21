import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/books_content_provider.dart';
import 'package:book_library/common/provider/categories_provider/book_theme_provider.dart';
import 'package:book_library/common/provider/categories_provider/text_type_provider.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/features/book_content/condition_orders/if_condition_orders.dart';
import 'package:book_library/features/profile/categories_pages/book_theme.dart';
import 'package:book_library/features/profile/categories_pages/font_style.dart';
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
  int currentIndex = 0;

  bool eyeShow = true;

  CarouselController carouselController = CarouselController();

  final String longText =
      "In a quaint little village nestled amidst rolling hills,there stood a cozy teahouse known as The Whispering Brew. Its wooden beams were weathered, and its windows adorned with lace curtains that swayed gently in the breeze. Inside, the aroma of freshly brewed tea danced in the air, inviting weary travelers and curious locals alike to step inside and indulge in a moment of tranquility.At the heart of the teahouse sat an old oak table, where an eclectic group of patrons gathered each afternoon. There was Mrs. Abernathy, the wise elder of the village, who sipped her Earl Grey with a knowing smile. Next to her sat young Timothy, an aspiring poet who found inspiration in the swirls of steam rising from his cup. And then there was Isabella, the enigmatic newcomer with a penchant for green tea and mysterious tales.One chilly afternoon, as rain pattered against the windows, a stranger walked into The Whispering Brew. His name was Elias, and he carried with him an air of quiet curiosity. He settled at the table and ordered a cup of chamomile, his eyes wandering over the faces of the other patrons with intrigue.As the hours passed and the rain continued to fall, the conversations around the table grew lively. Tales were spun, laughter echoed through the teahouse, and bonds were formed over shared cups of tea. And amidst it all, Elias listened intently, his own story yet to unfold. In a quaint little village nestled amidst rolling hills, there stood a cozy teahouse known as The Whispering Brew. Its wooden beams were weathered, and its windows adorned with lace curtains that swayed gently in the breeze. Inside, the aroma of freshly brewed tea danced in the air, inviting weary travelers and curious locals alike to step inside and indulge in a moment of tranquility.At the heart of the teahouse sat an old oak table, where an eclectic group of patrons gathered each afternoon. There was Mrs. Abernathy, the wise elder of the village, who sipped her Earl Grey with a knowing smile. Next to her sat young Timothy, an aspiring poet who found inspiration in the swirls of steam rising from his cup. And then there was Isabella, the enigmatic newcomer with a penchant for green tea and mysterious tales.One chilly afternoon, as rain pattered against the windows, a stranger walked into The Whispering Brew. His name was Elias, and he carried with him an air of quiet curiosity. He settled at the table and ordered a cup of chamomile, his eyes wandering over the faces of the other patrons with intrigue.As the hours passed and the rain continued to fall, the conversations around the table grew lively. Tales were spun, laughter echoed through the teahouse, and bonds were formed over shared cups of tea. And amidst it all, Elias listened intently, his own story yet to unfold. In a quaint little village nestled amidst rolling hills, there stood a cozy teahouse known as The Whispering Brew. Its wooden beams were weathered, and its windows adorned with lace curtains that swayed gently in the breeze. Inside, the aroma of freshly brewed tea danced in the air, inviting weary travelers and curious locals alike to step inside and indulge in a moment of tranquility.At the heart of the teahouse sat an old oak table, where an eclectic group of patrons gathered each afternoon. There was Mrs. Abernathy, the wise elder of the village, who sipped her Earl Grey with a knowing smile. Next to her sat young Timothy, an aspiring poet who found inspiration in the swirls of steam rising from his cup. And then there was Isabella, the enigmatic newcomer with a penchant for green tea and mysterious tales.One chilly afternoon, as rain pattered against the windows, a stranger walked into The Whispering Brew. His name was Elias, and he carried with him an air of quiet curiosity. He settled at the table and ordered a cup of chamomile, his eyes wandering over the faces of the other patrons with intrigue.As the hours passed and the rain continued to fall, the conversations around the table grew lively. Tales were spun, laughter echoed through the teahouse, and bonds were formed over shared cups of tea. And amidst it all, Elias listened intently, his own story yet to unfold.";
  List<String> slides = [];

  List<String> splitTextIntoChunks(String text, int maxWordPerSlide) {
    List<String> chunks = [];
    List<String> words = text.split(' ');

    String currentChunk = '';
    int currentLength = 0;
    for (String word in words) {
      // print("$maxWordPerSlide");
      if ((currentLength + word.length + 1) <= maxWordPerSlide) {
        // +1 for the space after each word
        if (currentChunk.isNotEmpty) {
          currentChunk += ' ';
          currentLength++;
        }
        currentChunk += word;
        currentLength += word.length;
      } else {
        chunks.add(currentChunk);
        currentChunk = word;
        currentLength = word.length;
      }
    }

    if (currentChunk.isNotEmpty) {
      chunks.add(currentChunk);
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
    // int maxWordsInSlide = (MediaQuery.of(context).size.height < 700.0 ? 600.0 : MediaQuery.of(context).size.height * 1.3).round();
    final fontSizeBox = Hive.box('saveBox');
    final double increaseFontSize = fontSizeBox.get('fontSize', defaultValue: 16.0);
    double height = MediaQuery.of(context).size.height;
    // int maxWordsInSlide = 0;

    int maxWordsInSlide = calculateMaxWordsInSlide(height, increaseFontSize);

    List<String> textChunks = splitTextIntoChunks(longText, maxWordsInSlide);

    final booksData = ref.watch(booksContentProvider);

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
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )
                  .toList(),

              borderRadius: BorderRadius.circular(10.0),
              icon: const Icon(Icons.keyboard_arrow_down), // Dropdown icon
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
                height: MediaQuery.of(context).size.height,
                viewportFraction: 1.0,
              ),
              items: textChunks.asMap().entries.map((entry) {
                final currentIndex = entry.key;
                final text = entry.value;

                // Retrieve the bookmarked state from Hive
                final box = Hive.box('saveBox');
                final key = 'bookmark_${widget.character.title}_$currentIndex';
                var isBookmarked = box.get(key, defaultValue: false);

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
                                trackColor: const Color(0xFF898989),
                                trackVisibility: true,
                                thumbVisibility: true,
                                radius: const Radius.circular(50),
                                thickness: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Container(
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
                                        textAlign: TextAlign.left,
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
                                      // Toggle the bookmarked state in Hive
                                      final newValue = !isBookmarked;
                                      box.put(key, newValue);
                                      setState(() {
                                        // Update the UI state
                                        isBookmarked = newValue;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        isBookmarked
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
