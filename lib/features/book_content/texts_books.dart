import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextsBooks extends StatefulWidget {
  const TextsBooks({super.key, required this.character, this.index});
  final BooksModel character;
  final index;
  @override
  State<TextsBooks> createState() => _TextsBooksState();
}

class _TextsBooksState extends State<TextsBooks> {
  bool lightMode = true;
  int index = 0;
  int hlao = 1;
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    List<String> pages = widget.character.pages!;

    List<Widget> textPage = [];

    textPage.add(
      Text(
        pages[index],
        style: TextStyle(fontSize: 20, color: lightMode ? Colors.white : Colors.black),
      ),
    );

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
            child: CarouselSlider.builder(
              carouselController: carouselController,
              itemCount: pages.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: lightMode ? AppColors.bg1 : const Color(0xFFFFF5D7)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.character.pages![index],
                              style: TextStyle(fontSize: 20, color: lightMode ? Colors.white : Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            maxRadius: 20,
                            backgroundColor: index > 0 ? AppColors.primary : AppColors.divider,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {
                                carouselController.previousPage();
                                if (index > 0) {
                                  setState(() {
                                    index--;
                                  });
                                }
                              },
                              color: lightMode ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            "${index + 1}",
                            style: TextStyle(fontSize: 30, color: lightMode ? Colors.white60 : Colors.black),
                          ),
                          CircleAvatar(
                            maxRadius: 20,
                            backgroundColor: AppColors.primary,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: () {
                                carouselController.nextPage();
                                if (index < pages.length - 1) {
                                  setState(() {
                                    index++;
                                  });
                                }
                              },
                              color: lightMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                height: double.infinity,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                reverse: false,
                onPageChanged: (index, reason) {},
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
