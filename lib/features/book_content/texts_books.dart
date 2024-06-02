import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/categories_provider/book_theme_provider.dart';
import 'package:book_library/common/provider/categories_provider/customize_text_provider.dart';
import 'package:book_library/common/provider/categories_provider/text_type_provider.dart';
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

  final String longText = '''
Emma stood at the window of her cozy apartment, watching the rain fall gently outside. The rhythmic patter against the glass had always been soothing to her, a natural symphony that paired perfectly with a steaming cup of tea. Tea was more than a beverage for Emma; it was a ritual, a comfort, and a connection to her past. She reached for the teapot on the counter, pouring herself a cup of her favorite Earl Grey. As she took her first sip, her mind wandered back to the letter she had received earlier that day.
It was an old, yellowed envelope with her name written in elegant, cursive handwriting. The sender's address was her grandmother's house, a place she had not visited since she was a child. Emma's grandmother had passed away years ago, but the letter felt like a bridge across time, bringing with it a sense of mystery and nostalgia. Later that evening, Emma settled into her favorite armchair with the mysterious letter. Her fingers trembled slightly as she broke the seal and unfolded the delicate paper. The letter was indeed from her grandmother, written shortly before her death. Emma's eyes widened as she read the words.
"My dearest Emma,
If you are reading this, then I have left this world, but there is something you must know. Our family has a secret, one that has been passed down through generations. It is connected to a special blend of tea, one that holds great power. You must follow the clues I have left and uncover the truth. It will not be easy, but I believe in you.
With all my love, Grandmother"
Emma's mind raced with questions. What secret could her grandmother have been keeping? And what power did this tea hold? Determined to find answers, she decided to follow the clues mentioned in the letter, starting with her favorite tea shop, "The Leaf and Petal."
The tea shop was a quaint establishment nestled in the heart of the city, a haven for tea lovers and a second home for Emma. The shop was adorned with vintage teapots, delicate china, and the soothing aroma of various tea blends. Mr. Patel, the shop owner, greeted Emma with a warm smile as she entered.
"Good morning, Emma! The usual?" he asked, already reaching for the canister of Earl Grey.
"Yes, please," Emma replied, her eyes scanning the shelves for anything new. As Mr. Patel prepared her tea, Emma's attention was drawn to a dusty, old tin at the back of a high shelf. It was labeled "Mystic Blend."
"What's that?" she asked, pointing to the tin.
Mr. Patel followed her gaze and chuckled. "Ah, the Mystic Blend. It's an old family recipe, long forgotten. My grandmother used to make it. I haven't thought about it in years."
Intrigued, Emma asked if she could try it. Mr. Patel obliged, and as he prepared the tea, a familiar face walked in. Sarah, a regular customer and Emma's friend, joined them at the counter.
"What's new?" Sarah asked, her eyes twinkling with curiosity.
"Trying something special today," Emma replied, holding up the cup of Mystic Blend. As she took her first sip, a rush of warmth and a hint of something unexplainable washed over her. It was unlike any tea she had ever tasted.
The next day, Emma returned to "The Leaf and Petal," the letter clutched in her hand. She shared her discovery with Mr. Patel, who was equally intrigued. He suggested they seek the help of a local historian, James, who had a reputation for uncovering hidden histories.
James was a tall, bespectacled man with an air of quiet confidence. When Emma and Mr. Patel approached him with their tale, he listened intently, his interest piqued. He agreed to help them, and together they began to unravel the mystery of the Mystic Blend.
Their first clue led them to an old, forgotten village mentioned in the letter. It was a place that had once thrived but was now largely abandoned. The villagers were wary of outsiders, but a kind elder, Mrs. Thompson, took pity on them and shared a crucial piece of information.
"There is a legend in this village," Mrs. Thompson began, her voice soft and trembling. "It speaks of a treasure hidden long ago, a treasure linked to a powerful tea blend. Many have sought it, but none have succeeded."
Following Mrs. Thompson's directions, Emma, James, and Mr. Patel explored the village, seeking any hint of the treasure. Their search led them to an abandoned manor on the outskirts, a place that had once belonged to a wealthy family with ties to Emma's ancestors.
Inside the manor, they found a hidden chamber filled with old books, maps, and artifacts. Among them was a diary, written by Emma's great-great-grandmother, detailing the creation of the Mystic Blend and its purported magical properties. The diary hinted at a series of puzzles that needed to be solved to uncover the full truth.
Days turned into weeks as Emma, James, and Mr. Patel delved deeper into the manor's secrets. They meticulously pieced together clues from the diary, cross-referencing with historical records and old maps. Their efforts led them to a hidden door behind a bookshelf, revealing a secret passage.
The passageway opened into a small room, where they found a series of intricate puzzles. Each puzzle was a test of wit and perseverance, designed to protect the treasure. Emma's heart pounded with anticipation as they worked through the challenges, one by one.
After what felt like an eternity, they solved the final riddle, unlocking a hidden compartment. Inside, they found an ornate chest filled with ancient tea blends, each with a unique label. The blends were said to grant wisdom, peace, and longevity to those who drank them.
Emma's eyes filled with tears as she realized the significance of their discovery. This was not just a treasure of material value but a legacy of her family, a gift that could bring great good to the world.
Emma faced a difficult decision. Should she share this discovery with the world, potentially risking exploitation and greed, or keep it hidden to protect its purity? She sought counsel from Mr. Patel and Sarah, both of whom understood the gravity of the situation.
In the end, Emma decided to use the tea discreetly, sharing its benefits with those in need while safeguarding its secrets. "The Leaf and Petal" became a sanctuary, a place where people could find solace and healing through the special blends.
Years later, the tea shop thrived, known far and wide as a place of peace and wisdom. Emma had found her calling, continuing her grandmother's legacy and bringing comfort to many. As she sipped her tea, she felt a deep sense of fulfillment, knowing she had made the right choice.
The journey had changed her, revealing the power of love, perseverance, and the magic of a simple cup of tea.
''';

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
      // extendBodyBehindAppBar: true,
      backgroundColor: pageTheme,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedSwitcher(
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
                : null,
          ),
        ),
        actions: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: _showEdgesScreen
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: openThemAndSetting,
                      child: Row(
                        children: [
                          Icon(
                            Icons.tune_rounded,
                            color: textColorLuminance,
                            size: 32,
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
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
          child: Column(
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
                    final story = entry.value;

                    final box = Hive.box('saveBox');
                    final key = 'bookmark_${widget.character.id}_${currentIndex}';
                    var isBookmarked = box.get(key, defaultValue: false);

                    return Builder(
                      builder: (BuildContext context) {
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
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                                    child: AnimatedSwitcher(
                                      duration: const Duration(milliseconds: 400),
                                      child: _showEdgesScreen
                                          ? isBookmarked
                                              ? const Icon(
                                                  Icons.bookmark,
                                                  size: 28,
                                                  color: Colors.red,
                                                )
                                              : Icon(
                                                  Icons.bookmark_outline,
                                                  color: textColorLuminance,
                                                  size: 28,
                                                )
                                          : null,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
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
