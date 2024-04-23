import 'package:book_library/common/src/constants/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestingAh extends ConsumerStatefulWidget {
  const TestingAh({
    super.key,
  });

  @override
  ConsumerState<TestingAh> createState() => _TestingAhState();
}

class _TestingAhState extends ConsumerState<TestingAh> {
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
    int maxCharsPerSlide = (MediaQuery.of(context).size.height).round();
    List<String> textChunks = splitTextIntoChunks(longText, maxCharsPerSlide - 5);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.bg2,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          const SizedBox(height: 100),
          Text(
            "hlao",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double carouselHeight = constraints.maxHeight; // Get the available height

                return CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    scrollPhysics: BouncingScrollPhysics(),
                    height: carouselHeight,
                    viewportFraction: 1.0,
                  ),
                  items: textChunks.map((text) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  text,
                                ),
                              ),
                              Text("${carouselHeight.round()}"),
                              Text("${maxCharsPerSlide}")
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
