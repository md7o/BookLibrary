import 'package:book_library/common/models/book_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class experince extends ConsumerStatefulWidget {
  const experince({
    super.key,
  });

  @override
  ConsumerState<experince> createState() => _experinceState();
}

class _experinceState extends ConsumerState<experince> {
  final String longText =
      "In a quaint little village nestled amidst rolling hills,there stood a cozy teahouse known as The Whispering Brew. Its wooden beams were weathered, and its windows adorned with lace curtains that swayed gently in the breeze. Inside, the aroma of freshly brewed tea danced in the air, inviting weary travelers and curious locals alike to step inside and indulge in a moment of tranquility.At the heart of the teahouse sat an old oak table, where an eclectic group of patrons gathered each afternoon. There was Mrs. Abernathy, the wise elder of the village, who sipped her Earl Grey with a knowing smile. Next to her sat young Timothy, an aspiring poet who found inspiration in the swirls of steam rising from his cup. And then there was Isabella, the enigmatic newcomer with a penchant for green tea and mysterious tales.One chilly afternoon, as rain pattered against the windows, a stranger walked into The Whispering Brew. His name was Elias, and he carried with him an air of quiet curiosity. He settled at the table and ordered a cup of chamomile, his eyes wandering over the faces of the other patrons with intrigue.As the hours passed and the rain continued to fall, the conversations around the table grew lively. Tales were spun, laughter echoed through the teahouse, and bonds were formed over shared cups of tea. And amidst it all, Elias listened intently, his own story yet to unfold. In a quaint little village nestled amidst rolling hills, there stood a cozy teahouse known as The Whispering Brew. Its wooden beams were weathered, and its windows adorned with lace curtains that swayed gently in the breeze. Inside, the aroma of freshly brewed tea danced in the air, inviting weary travelers and curious locals alike to step inside and indulge in a moment of tranquility.At the heart of the teahouse sat an old oak table, where an eclectic group of patrons gathered each afternoon. There was Mrs. Abernathy, the wise elder of the village, who sipped her Earl Grey with a knowing smile. Next to her sat young Timothy, an aspiring poet who found inspiration in the swirls of steam rising from his cup. And then there was Isabella, the enigmatic newcomer with a penchant for green tea and mysterious tales.One chilly afternoon, as rain pattered against the windows, a stranger walked into The Whispering Brew. His name was Elias, and he carried with him an air of quiet curiosity. He settled at the table and ordered a cup of chamomile, his eyes wandering over the faces of the other patrons with intrigue.As the hours passed and the rain continued to fall, the conversations around the table grew lively. Tales were spun, laughter echoed through the teahouse, and bonds were formed over shared cups of tea. And amidst it all, Elias listened intently, his own story yet to unfold. In a quaint little village nestled amidst rolling hills, there stood a cozy teahouse known as The Whispering Brew. Its wooden beams were weathered, and its windows adorned with lace curtains that swayed gently in the breeze. Inside, the aroma of freshly brewed tea danced in the air, inviting weary travelers and curious locals alike to step inside and indulge in a moment of tranquility.At the heart of the teahouse sat an old oak table, where an eclectic group of patrons gathered each afternoon. There was Mrs. Abernathy, the wise elder of the village, who sipped her Earl Grey with a knowing smile. Next to her sat young Timothy, an aspiring poet who found inspiration in the swirls of steam rising from his cup. And then there was Isabella, the enigmatic newcomer with a penchant for green tea and mysterious tales.One chilly afternoon, as rain pattered against the windows, a stranger walked into The Whispering Brew. His name was Elias, and he carried with him an air of quiet curiosity. He settled at the table and ordered a cup of chamomile, his eyes wandering over the faces of the other patrons with intrigue.As the hours passed and the rain continued to fall, the conversations around the table grew lively. Tales were spun, laughter echoed through the teahouse, and bonds were formed over shared cups of tea. And amidst it all, Elias listened intently, his own story yet to unfold.";

  List<String> splitText(String text, double containerHeight, TextStyle textStyle) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      maxLines: 9999, // A large number to ensure all text is measured
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: double.infinity);

    final textHeight = textPainter.size.height;
    final charLimit = (text.length * containerHeight ~/ textHeight).toInt();

    List<String> textParts = [];

    // Split the text into parts based on the calculated character limit
    for (int i = 0; i < text.length; i += charLimit) {
      textParts.add(text.substring(i, i + charLimit < text.length ? i + charLimit : text.length));
    }

    return textParts;
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height; // Get the container height
    TextStyle textStyle = TextStyle(fontSize: 24.0); // Example text style
    List<String> pages = splitText(longText, containerHeight, textStyle);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Book'),
      ),
      body: PageView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return BookContentPage(content: pages[index]);
        },
      ),
    );
  }
}

class BookContentPage extends StatelessWidget {
  final String content;

  BookContentPage({required this.content});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          content,
          style: TextStyle(fontSize: 24.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
