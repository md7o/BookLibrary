import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/provider/favorite_provider.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/fonts.dart';
import 'package:book_library/features/book_content/texts_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookDetails extends ConsumerStatefulWidget {
  final int index;
  final BooksModel cnt;
  const BookDetails({
    super.key,
    required this.index,
    required this.cnt,
  });

  @override
  ConsumerState<BookDetails> createState() => _ssState();
}

class _ssState extends ConsumerState<BookDetails> {
  @override
  Widget build(BuildContext context) {
    final favoriteBooks = ref.watch(favoriteBooksProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black26,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      body: Hero(
        tag: widget.index,
        child: Material(
          // type: MaterialType.transparency,
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned.fill(
                bottom: 100,
                child: Image.network(
                  widget.cnt.coverbook!,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 320,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.bg2.withOpacity(0.6),
                        AppColors.bg2,
                        AppColors.bg2,
                      ], // Example gradient colors, replace with your desired colors
                      stops: const [0, 0.3, 0.6, 1],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(color: AppColors.bg2),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.cnt.title!,
                                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.cnt.author!,
                                      style: const TextStyle(fontSize: AppFontSize.medium, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(
                                    ref.watch(favoriteBooksProvider.notifier).isClick(widget.cnt)
                                        ? Icons.bookmark_rounded
                                        : Icons.bookmark_add_outlined,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    ref.watch(favoriteBooksProvider.notifier).toggleFavorite(widget.cnt);
                                    setState(() {});
                                    ScaffoldMessenger.of(context).clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(ref.watch(favoriteBooksProvider.notifier).isClick(widget.cnt)
                                            ? 'The Book is added to favorite'
                                            : 'The Book is removed from favorite'),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 20, left: 40, bottom: 10),
                              child: Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 40,
                              ),
                              child: Text(
                                'In the wasteland that was once Aethel, the metropolis of tomorrow, Kai,Cloaked enigma, Stood defiant against the dying embers of a poisoned sky. Ten years ago, Aetherium reactors pulsed with brilliance, Powering civilization on the cusp of utopia.',
                                style: TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(right: 40, left: 40, bottom: 40, top: 20),
                            child: SizedBox(
                              width: double.infinity,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF37AA73).withOpacity(0.2),
                                      blurRadius: 30,
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => TextsBooks(character: widget.cnt),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                  ),
                                  child: const Text(
                                    "Read Now",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
