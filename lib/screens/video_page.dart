import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kybele_gen2/templates/page/page.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

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

  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;
  @override
  void initState() {
    super.initState();
    initializePlayer();
  }
  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        VideoPlayerController.network(widget.video_List.video_path!);
    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }
  void _createChewieController() {
    // final subtitles = [
    //     Subtitle(
    //       index: 0,
    //       start: Duration.zero,
    //       end: const Duration(seconds: 10),
    //       text: 'Hello from subtitles',
    //     ),
    //     Subtitle(
    //       index: 0,
    //       start: const Duration(seconds: 10),
    //       end: const Duration(seconds: 20),
    //       text: 'Whats up? :)',
    //     ),
    //   ];
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
      hideControlsTimer: const Duration(seconds: 1),
      // Try playing around with some of these other options:
      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }
  Widget body(BuildContext context) {
    return 
                    Expanded(
                      child: Center(
                        child: _chewieController != null &&
                            _chewieController!
                                .videoPlayerController.value.isInitialized
                            ? Chewie(
                          controller: _chewieController!,
                        )
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(height: 20),
                            Text('Loading'),
                          ],
                        ),
                      ),
                    );
  }
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