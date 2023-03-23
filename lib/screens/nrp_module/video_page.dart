import 'package:flutter/material.dart';
import 'package:kybele_gen2/models/models.dart' show Video;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TutorialPage extends StatefulWidget {
  final Video videoList;
  final int videoIndex;

  const TutorialPage(this.videoList, this.videoIndex, {super.key});

  @override
  State<TutorialPage> createState() => TutorialPageState();
}

class TutorialPageState extends State<TutorialPage> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    String url = widget.videoList.videoPath;
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
    );
  }

  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => YoutubePlayerBuilder(
        player: YoutubePlayer(controller: controller),
        builder: (context, player) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Row(children: [Text(widget.videoList.title)]),
          ),
          body: Column(children: [player]),
        ),
      );
}
