import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/books_content_provider.dart';
import 'package:book_library/common/provider/categories_provider/book_mark_provider.dart';
import 'package:book_library/common/provider/categories_provider/book_theme_provider.dart';
import 'package:book_library/common/provider/categories_provider/text_type_provider.dart';
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

  bool EyeShow = true;

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

  @override
  Widget build(BuildContext context) {
    int maxCharsPerSlide = (MediaQuery.of(context).size.height < 600.0 ? 600.0 : MediaQuery.of(context).size.height * 1.5).round();
    List<String> textChunks = splitTextIntoChunks(longText, maxCharsPerSlide);

    final booksData = ref.watch(booksContentProvider);

    final fontSizeBox = Hive.box('saveBox');
    final fontSize = fontSizeBox.get('fontSize', defaultValue: 16.0);

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
            if (EyeShow)
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
          if (EyeShow)
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EditFont(),
                  ),
                );
              },
              child: Text(
                "FontSize: $fontSize",
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  decorationColor: textColorLuminance,
                  decorationThickness: 1.5,
                ),
              ),
            ),
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
                final isBookmarked = ref.watch(bookMarkProvider(Tuple3(true, widget.character.pages!, currentIndex)).state);
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
                              child: Scrollbar(
                                thumbVisibility: true,
                                thickness: 1,
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: Container(
                                      height: MediaQuery.of(context).size.height <= 700 ? 500 : 600,
                                      alignment: Alignment.center,
                                      child: Text(
                                        text,
                                        style: GoogleFonts.getFont(
                                          _getSelectedFont(fontType),
                                          fontSize: fontSize,
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
                                  icon: EyeShow
                                      ? const Icon(
                                          Icons.remove_red_eye,
                                          size: 25,
                                        )
                                      : const Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 25,
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      EyeShow = !EyeShow;
                                    });
                                  },
                                ),
                                if (EyeShow)
                                  InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      // ref.read(bookMarkProvider(widget.character.pages!).notifier).state = !isBookmarked;
                                      ref.read(bookMarkProvider(Tuple3(true, widget.character.pages!, currentIndex)).notifier).state =
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
                                            : const Icon(
                                                Icons.bookmark_outline,
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
                                // Text(
                                //   "${index + 1}",
                                //   style: TextStyle(
                                //     color: textColorLuminance,
                                //     fontSize: 20,
                                //   ),
                                // ),
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

          // Padding(
          //   padding: const EdgeInsets.only(bottom: 30),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       CircleAvatar(
          //         maxRadius: 20,
          //         backgroundColor: index > 0 ? AppColors.primary : AppColors.divider,
          //         child: IconButton(
          //           icon: const Icon(Icons.arrow_back),
          //           onPressed: () {
          //             carouselController.previousPage();
          //             if (index > 0) {
          //               setState(() {
          //                 index--;
          //               });
          //             }
          //           },
          //           color: lightMode ? Colors.white : Colors.black,
          //         ),
          //       ),
          //       Text(
          //         "${index}",
          //         style: TextStyle(fontSize: 30, color: lightMode ? Colors.white60 : Colors.black),
          //       ),
          //       CircleAvatar(
          //         maxRadius: 20,
          //         backgroundColor: AppColors.primary,
          //         child: IconButton(
          //           icon: const Icon(Icons.arrow_forward),
          //           onPressed: () {
          //             carouselController.nextPage();
          //             if (index < pages.length - 1) {
          //               setState(
          //                 () {
          //                   index++;
          //                 },
          //               );
          //             }
          //           },
          //           color: lightMode ? Colors.white : Colors.black,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  String _getSelectedFont(int fontIndex) {
    switch (fontIndex) {
      case 0:
        return 'Cairo';
      case 1:
        return 'Sevillana';
      case 2:
        return 'Montserrat';
      default:
        return 'Roboto';
    }
  }
}
