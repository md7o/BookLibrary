import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/categories_provider/text_type_provider.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
  bool lightMode = true;
  int index = 0;
  int hlao = 1;
  CarouselController carouselController = CarouselController();

  final String longText =
      "Once upon a time, in a quaint village nestled between rolling hills and whispering forests, there lived a young girl named Elara. Elara was no ordinary girl; she possessed a heart as vast as the sky and a curiosity that knew no bounds. Her days were spent exploring the woods, listening to the tales of the elders, and dreaming of adventures beyond the horizonOne crisp autumn morning, as the golden sun peeked over the treetops, Elara set out on her usual journey through the forest. She hummed a tune passed down by her grandmother, her steps light and eager. Little did she know that this day would mark the beginning of an extraordinary adventure.As Elara wandered deeper into the woods, she stumbled upon a hidden path she had never seen before. Intrigued, she followed it, her heart pounding with excitement. The path led her to a clearing where a magnificent oak tree stood, its branches reaching for the heavens like outstretched arms.Beneath the tree sat a wise old woman with eyes like the depths of the ocean and a smile that seemed to hold the secrets of the universe. Greetings, child, she said, her voice gentle yet powerful. s eyes widened with wonder as she told the old woman of her thirst for adventure and her longing to explore the world beyond the village. The woman nodded knowingly, her silver hair shimmering in the dappled sunlight.Once upon a time, in a quaint village nestled between rolling hills and whispering forests, there lived a young girl named Elara. Elara was no ordinary girl; she possessed a heart as vast as the sky and a curiosity that knew no bounds. Her days were spent exploring the woods, listening to the tales of the elders, and dreaming of adventures beyond the horizonOne crisp autumn morning, as the golden sun peeked over the treetops, Elara set out on her usual journey through the forest. She hummed a tune passed down by her grandmother, her steps light and eager. Little did she know that this day would mark the beginning of an extraordinary adventure.As Elara wandered deeper into the woods, she stumbled upon a hidden path she had never seen before. Intrigued, she followed it, her heart pounding with excitement. The path led her to a clearing where a magnificent oak tree stood, its branches reaching for the heavens like outstretched arms.Beneath the tree sat a wise old woman with eyes like the depths of the ocean and a smile that seemed to hold the secrets of the universe. Greetings, child, she said, her voice gentle yet powerful. s eyes widened with wonder as she told the old woman of her thirst for adventure and her longing to explore the world beyond the village. The woman nodded knowingly, her silver hair shimmering in the dappled sunlight.Once upon a time, in a quaint village nestled between rolling hills and whispering forests, there lived a young girl named Elara. Elara was no ordinary girl; she possessed a heart as vast as the sky and a curiosity that knew no bounds. Her days were spent exploring the woods, listening to the tales of the elders, and dreaming of adventures beyond the horizonOne crisp autumn morning, as the golden sun peeked over the treetops, Elara set out on her usual journey through the forest. She hummed a tune passed down by her grandmother, her steps light and eager. Little did she know that this day would mark the beginning of an extraordinary adventure.As Elara wandered deeper into the woods, she stumbled upon a hidden path she had never seen before. Intrigued, she followed it, her heart pounding with excitement. The path led her to a clearing where a magnificent oak tree stood, its branches reaching for the heavens like outstretched arms.Beneath the tree sat a wise old woman with eyes like the depths of the ocean and a smile that seemed to hold the secrets of the universe. Greetings, child, she said, her voice gentle yet powerful. s eyes widened with wonder as she told the old woman of her thirst for adventure and her longing to explore the world beyond the village. The woman nodded knowingly, her silver hair shimmering in the dappled sunlight.Once upon a time, in a quaint village nestled between rolling hills and whispering forests, there lived a young girl named Elara. Elara was no ordinary girl; she possessed a heart as vast as the sky and a curiosity that knew no bounds. Her days were spent exploring the woods, listening to the tales of the elders, and dreaming of adventures beyond the horizonOne crisp autumn morning, as the golden sun peeked over the treetops, Elara set out on her usual journey through the forest. She hummed a tune passed down by her grandmother, her steps light and eager. Little did she know that this day would mark the beginning of an extraordinary adventure.As Elara wandered deeper into the woods, she stumbled upon a hidden path she had never seen before. Intrigued, she followed it, her heart pounding with excitement. The path led her to a clearing where a magnificent oak tree stood, its branches reaching for the heavens like outstretched arms.Beneath the tree sat a wise old woman with eyes like the depths of the ocean and a smile that seemed to hold the secrets of the universe. Greetings, child, she said, her voice gentle yet powerful. s eyes widened with wonder as she told the old woman of her thirst for adventure and her longing to explore the world beyond the village. The woman nodded knowingly, her silver hair shimmering in the dappled sunlight.Once upon a time, in a quaint village nestled between rolling hills and whispering forests, there lived a young girl named Elara. Elara was no ordinary girl; she possessed a heart as vast as the sky and a curiosity that knew no bounds. Her days were spent exploring the woods, listening to the tales of the elders, and dreaming of adventures beyond the horizonOne crisp autumn morning, as the golden sun peeked over the treetops, Elara set out on her usual journey through the forest. She hummed a tune passed down by her grandmother, her steps light and eager. Little did she know that this day would mark the beginning of an extraordinary adventure.As Elara wandered deeper into the woods, she stumbled upon a hidden path she had never seen before. Intrigued, she followed it, her heart pounding with excitement. The path led her to a clearing where a magnificent oak tree stood, its branches reaching for the heavens like outstretched arms.Beneath the tree sat a wise old woman with eyes like the depths of the ocean and a smile that seemed to hold the secrets of the universe. Greetings, child, she said, her voice gentle yet powerful. s eyes widened with wonder as she told the old woman of her thirst for adventure and her longing to explore the world beyond the village. The woman nodded knowingly, her silver hair shimmering in the dappled sunlight.Once upon a time, in a quaint village nestled between rolling hills and whispering forests, there lived a young girl named Elara. Elara was no ordinary girl; she possessed a heart as vast as the sky and a curiosity that knew no bounds. Her days were spent exploring the woods, listening to the tales of the elders, and dreaming of adventures beyond the horizonOne crisp autumn morning, as the golden sun peeked over the treetops, Elara set out on her usual journey through the forest. She hummed a tune passed down by her grandmother, her steps light and eager. Little did she know that this day would mark the beginning of an extraordinary adventure.As Elara wandered deeper into the woods, she stumbled upon a hidden path she had never seen before. Intrigued, she followed it, her heart pounding with excitement. The path led her to a clearing where a magnificent oak tree stood, its branches reaching for the heavens like outstretched arms.Beneath the tree sat a wise old woman with eyes like the depths of the ocean and a smile that seemed to hold the secrets of the universe. Greetings, child, she said, her voice gentle yet powerful. s eyes widened with wonder as she told the old woman of her thirst for adventure and her longing to explore the world beyond the village. The woman nodded knowingly, her silver hair shimmering in the dappled sunlight.Once upon a time, in a quaint village nestled between rolling hills and whispering forests, there lived a young girl named Elara. Elara was no ordinary girl; she possessed a heart as vast as the sky and a curiosity that knew no bounds. Her days were spent exploring the woods, listening to the tales of the elders, and dreaming of adventures beyond the horizonOne crisp autumn morning, as the golden sun peeked over the treetops, Elara set out on her usual journey through the forest. She hummed a tune passed down by her grandmother, her steps light and eager. Little did she know that this day would mark the beginning of an extraordinary adventure.As Elara wandered deeper into the woods, she stumbled upon a hidden path she had never seen before. Intrigued, she followed it, her heart pounding with excitement. The path led her to a clearing where a magnificent oak tree stood, its branches reaching for the heavens like outstretched arms.Beneath the tree sat a wise old woman with eyes like the depths of the ocean and a smile that seemed to hold the secrets of the universe. Greetings, child, she said, her voice gentle yet powerful. s eyes widened with wonder as she told the old woman of her thirst for adventure and her longing to explore the world beyond the village. The woman nodded knowingly, her silver hair shimmering in the dappled sunlight.";

  List<String> splitTextIntoChunks(String text, int maxCharsPerSlide) {
    List<String> chunks = [];
    for (int i = 0; i < text.length; i += maxCharsPerSlide) {
      chunks.add(text.substring(i, i + maxCharsPerSlide < text.length ? i + maxCharsPerSlide : text.length));
    }
    return chunks;
  }

  @override
  Widget build(BuildContext context) {
    final double slideLength = MediaQuery.of(context).size.height;
    int maxCharsPerSlide = (MediaQuery.of(context).size.height).round();
    List<String> textChunks = splitTextIntoChunks(longText, maxCharsPerSlide);

    final fontSizeBox = Hive.box('saveBox');
    final fontSize = fontSizeBox.get('fontSize', defaultValue: 16.0);

    final fontType = ref.watch(fontTypeProvider);

    List<String> pages = widget.character.pages!;

    // textPage.add(
    //   Text(
    //     pages[index],
    //     style: TextStyle(fontSize: 20, color: lightMode ? Colors.white : Colors.black),
    //   ),
    // );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: lightMode ? AppColors.bg1 : const Color(0xFFFFF5D7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: (IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              lightMode = !lightMode;
            });
          },
          icon: Icon(
            Icons.close,
            color: lightMode ? Colors.white : Colors.black,
            size: 30,
          ),
        )),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                lightMode = !lightMode;
              });
            },
            icon: lightMode
                ? const Icon(
                    Icons.dark_mode,
                    color: Colors.white,
                    size: 30,
                  )
                : const Icon(
                    Icons.light_mode,
                    color: Colors.black,
                    size: 30,
                  ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 100),
          Text(
            widget.character.title!,
            style: TextStyle(
              color: lightMode ? Colors.white : Colors.black,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                enableInfiniteScroll: false,
                height: MediaQuery.of(context).size.height,
                viewportFraction: 1.0,
              ),
              items: textChunks.map((text) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      child: Center(
                        child: Text(
                          text,
                          style: GoogleFonts.getFont(_getSelectedFont(fontType), fontSize: fontSize),

                          //  TextStyle(fontSize: fontSize, color: Colors.white),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              // Expanded(
              //   child: CarouselSlider.builder(
              //     carouselController: carouselController,
              //     itemCount: pages.length,
              //     itemBuilder: (BuildContext context, int index, int realIndex) {
              //       return Column(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Container(
              //             decoration: BoxDecoration(color: lightMode ? AppColors.bg1 : const Color(0xFFFFF5D7)),
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 20),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Text(
              //                     "$textPage",
              //                     // widget.character.pages![index],
              //                     style: TextStyle(fontSize: fontSize, color: lightMode ? Colors.white : Colors.black),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(bottom: 30),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //               children: [
              //                 CircleAvatar(
              //                   maxRadius: 20,
              //                   backgroundColor: index > 0 ? AppColors.primary : AppColors.divider,
              //                   child: IconButton(
              //                     icon: const Icon(Icons.arrow_back),
              //                     onPressed: () {
              //                       carouselController.previousPage();
              //                       if (index > 0) {
              //                         setState(() {
              //                           index--;
              //                         });
              //                       }
              //                     },
              //                     color: lightMode ? Colors.white : Colors.black,
              //                   ),
              //                 ),
              //                 Text(
              //                   "${index + 1}",
              //                   style: TextStyle(fontSize: 30, color: lightMode ? Colors.white60 : Colors.black),
              //                 ),
              //                 CircleAvatar(
              //                   maxRadius: 20,
              //                   backgroundColor: AppColors.primary,
              //                   child: IconButton(
              //                     icon: const Icon(Icons.arrow_forward),
              //                     onPressed: () {
              //                       carouselController.nextPage();
              //                       if (index < pages.length - 1) {
              //                         setState(() {
              //                           index++;
              //                         });
              //                       }
              //                     },
              //                     color: lightMode ? Colors.white : Colors.black,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       );
              //     },
              //     options: CarouselOptions(
              //       height: double.infinity,
              //       aspectRatio: 16 / 9,
              //       viewportFraction: 1,
              //       enableInfiniteScroll: false,
              //       reverse: false,
              //       onPageChanged: (index, reason) {},
              //       scrollDirection: Axis.horizontal,
              //     ),
              //   ),
              // ),
            ),
          ),
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
