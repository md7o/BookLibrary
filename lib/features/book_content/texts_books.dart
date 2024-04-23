import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/categories_provider/book_theme_provider.dart';
import 'package:book_library/common/provider/categories_provider/text_type_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TextsBooks extends ConsumerStatefulWidget {
  const TextsBooks({super.key, required this.character, this.index});

  final BooksModel character;
  final index;
  @override
  ConsumerState<TextsBooks> createState() => _TextsBooksState();
}

class _TextsBooksState extends ConsumerState<TextsBooks> {
  int currentIndex = 0;

  CarouselController carouselController = CarouselController();

  final String longText =
      "In the 2021-2022 UEFA Champions League season, Real Madrid had quite the journey to clinch the title. Under the management of Carlo Ancelotti, who returned to the club for his second spell, Real Madrid embarked on a campaign filled with thrilling moments and dramatic victories.The group stage saw Real Madrid dominate, topping their group with relative ease. Led by seasoned veterans like Karim Benzema and Sergio Ramos, along with emerging talents like Vinícius Júnior and Eduardo Camavinga, the team displayed a blend of experience and youth.As they progressed through the knockout stages, they faced tough challenges from some of Europe's elite clubs. In the Round of 16, they squared off against Italian giants Inter Milan in a fiercely contested tie. Real Madrid showcased their resilience, overcoming Inter with an aggregate scoreline that saw them through to the quarter-finals.The quarter-finals brought another stern test as they were pitted against Premier League powerhouse Manchester City. In a highly anticipated matchup, Real Madrid's tactical prowess and individual brilliance shone through, as they managed to outclass Manchester City over two legs, booking their ticket to the semi-finals.The semi-final stage brought a clash of titans as Real Madrid faced off against their arch-rivals, Barcelona. The El Clásico showdown captivated football fans worldwide, with Real Madrid prevailing in a tightly contested battle, earning them a spot in the Champions League final.In the final, held at the iconic Atatürk Olympic Stadium in Istanbul, Real Madrid met English side Chelsea in a blockbuster encounter. The match lived up to its billing, with both teams showcasing their quality in an exhilarating contest. However, it was Real Madrid who emerged victorious, edging out Chelsea in a thrilling encounter to claim their record-extending 14th UEFA Champions League title.With their triumph, Real Madrid once again asserted their dominance on the European stage, etching their name in football history as one of the most successful clubs in the competition's illustrious history. In the 2021-2022 UEFA Champions League season, Real Madrid had quite the journey to clinch In the 2021-2022 UEFA Champions League season, Real Madrid had quite the journey to clinch AHH AHHAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH AHHAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHAHHAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHAHHAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL";
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
    int maxCharsPerSlide =
        (MediaQuery.of(context).size.height < 650 ? MediaQuery.of(context).size.height - 400 : MediaQuery.of(context).size.height - 350).round();
    List<String> textChunks = splitTextIntoChunks(longText, maxCharsPerSlide);

    final fontSizeBox = Hive.box('saveBox');
    final fontSize = fontSizeBox.get('fontSize', defaultValue: 16.0);

    final fontType = ref.watch(fontTypeProvider);
    final pageTheme = ref.watch(containerColorProvider);
    final textColorLuminance = pageTheme.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notifier = ref.read(containerColorProvider.notifier);
      await notifier.loadSavedColor();
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: pageTheme,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: (IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.close,
            color: textColorLuminance,
            size: 30,
          ),
        )),
      ),
      body: Column(
        children: [
          const SizedBox(height: 100),
          Text(
            widget.character.title!,
            style: TextStyle(
              color: textColorLuminance,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double carouselHeight = constraints.maxHeight;

                return CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    scrollPhysics: PageScrollPhysics(),
                    height: MediaQuery.of(context).size.height,
                    viewportFraction: 1.0,
                  ),
                  items: textChunks.map((text) {
                    return Center(
                      child: Builder(
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        text,
                                        style: TextStyle(fontSize: fontSize, color: textColorLuminance),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              },
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
        return 'Roboto';
      case 1:
        return 'Open Sans';
      case 2:
        return 'Montserrat';
      default:
        return 'Roboto';
    }
  }
}
