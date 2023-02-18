import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kybele_gen2/templates/page/page.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../databases/modules.dart';
import '../old/nav/header.dart';

class TutorialPage extends StatefulWidget {
  final Video video_List;
  final int videoIndex;
  TutorialPage(
      this.video_List,
      this.videoIndex,
      );
  @override
  _ChewieDemoState createState() => _ChewieDemoState();
}
class _ChewieDemoState extends State<TutorialPage> {
  late YoutubePlayerController controller;
  @override
  void initState(){
    super.initState();
    String url  = widget.video_List.video_path!;
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
    builder: (context,player) => Container(height: MediaQuery.of(context).size.height * .75, child: Column(mainAxisAlignment: MainAxisAlignment.center,
    children:[player,]
    )),
  );

  @override
  Widget build(BuildContext context){
    return KybelePage.fixedWithHeader(
      hasHeaderClose: true,
      hasHeaderIcon: true,
      hasBottomActionButton: false,
      bodyWidget: body(context),
      headerText: widget.video_List.video_title!,
      headerIcon: Icons.ondemand_video_rounded,
      headerIconBkgColor: Color(0xfff9e1f5),
      headerIconColor: Color(0xff8e4383),
    );
  }
}