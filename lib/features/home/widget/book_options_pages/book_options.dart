import 'package:book_library/features/home/widget/book_options_pages/random_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookOptions extends ConsumerStatefulWidget {
  const BookOptions({super.key});

  @override
  ConsumerState<BookOptions> createState() => _BookOptionsState();
}

class _BookOptionsState extends ConsumerState<BookOptions> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const RandomBook(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Random Book',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
