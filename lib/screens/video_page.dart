import 'package:flutter/material.dart';
import 'package:kybele_gen2/templates/page/page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../databases/modules.dart';

class TutorialPage extends StatefulWidget {

  final Video videoList;
  final int videoIndex;

  const TutorialPage(
      this.videoList,
      this.videoIndex,
      {super.key});
  @override

  State<TutorialPage> createState() => TutorialPageState();
}
class TutorialPageState extends State<TutorialPage> {
  late YoutubePlayerController controller;
  @override
  void initState(){
    super.initState();
    String url  = widget.videoList.videoPath!;
    controller = YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(url)!);
  }
  
  @override
  void deactivate(){
    controller.pause();
    super.deactivate();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  Widget body(BuildContext context) => YoutubePlayerBuilder(
    player: YoutubePlayer(controller: controller),
    builder: (context,player) => SizedBox(
        height: MediaQuery.of(context).size.height * .75,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[player,]
        ),
    ),
  );

  @override
  Widget build(BuildContext context){
    return KybelePage.fixedWithHeader(
      hasHeaderClose: true,
      hasHeaderIcon: true,
      hasBottomActionButton: false,
      bodyWidget: body(context),
      headerText: widget.videoList.videoTitle!,
      headerIcon: Icons.ondemand_video_rounded,
      headerIconBkgColor: const Color(0xfff9e1f5),
      headerIconColor: const Color(0xff8e4383),
    );
  }
}