import 'package:audioplayers/audioplayers.dart';
import 'package:book_library/common/models/book_model.dart';
import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookContent extends ConsumerStatefulWidget {
  const BookContent({super.key, required this.cnt, this.index});
  final BooksModel cnt;
  final index;

  @override
  ConsumerState<BookContent> createState() => _BookContentState();
}

class _BookContentState extends ConsumerState<BookContent> {
  String formatTime(Duration duration) {
    String towDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$towDigitSeconds";

    return formattedTime;
  }

  final audioPlayer = AudioPlayer();

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onPositionChanged.listen((newPostion) {
      setState(() {
        position = newPostion;
      });
    });
  }

  bool isIconChanged = false;

  void _changeIcon() {
    setState(() {
      isIconChanged = !isIconChanged;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090909),
      appBar: AppBar(
          backgroundColor: const Color(0xFF090909),
          centerTitle: true,
          title: Text(widget.cnt.classification!),
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(audioPlayer.pause());
              },
              icon: const Icon(Icons.arrow_back_ios))),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: Hero(
              tag: widget.index,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // Image border
                child: Image.network(widget.cnt.coverbook!,
                    fit: BoxFit.cover,
                    height:
                        MediaQuery.of(context).size.height > 750 ? 350 : 270,
                    width: 250),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height > 750 ? 40 : 20,
          ),
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
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.cnt.author!,
                      style: const TextStyle(
                        fontSize: AppFontSize.medium,
                      ),
                    ),
                    Opacity(
                      opacity: 0.7,
                      child: Text(
                        widget.cnt.classification!,
                        style: const TextStyle(
                          fontSize: AppFontSize.small,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: isIconChanged
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                  iconSize: 35,
                  onPressed: () {
                    _changeIcon();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
                trackHeight: 6,
              ),
              child: Slider(
                activeColor: AppColors.primary,
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) async {
                  audioPlayer.seek(Duration(seconds: value.toInt()));

                  await audioPlayer.resume();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatTime(position)),
                Text(formatTime(duration)),
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: AppColors.primary,
            maxRadius: MediaQuery.of(context).size.height > 750 ? 30 : 25,
            child: IconButton(
              onPressed: () async {
                if (isPlaying) {
                  await audioPlayer.pause();
                  audioPlayer.setReleaseMode(ReleaseMode.loop);
                } else {
                  String url =
                      'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3';
                  await audioPlayer.play(UrlSource(
                    url,
                  ));
                }
              },
              icon: isPlaying
                  ? Icon(
                      Icons.pause,
                      size: MediaQuery.of(context).size.height > 750 ? 35 : 25,
                    )
                  : const Icon(
                      Icons.play_arrow_rounded,
                      size: 40,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  setVolume(double volume) {
    audioPlayer.setVolume(volume);
  }
}
