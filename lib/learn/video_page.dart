import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'video_library.dart';
import 'package:kybele_gen2/learn/modules.dart';



class VideoList extends StatelessWidget {

  final Module module;
  final int ignore_index;

  const VideoList(this.module, this.ignore_index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < module.numVideos; ++i)
          Column(
            children: [
              YouTubeVideoButton3(module, i),
            ],
          ),
        SizedBox(height: 5),
      ],
    );
  }
}


class TutorialPage extends StatefulWidget {

  final Module module;
  final int videoIndex;

  TutorialPage(
      this.module,
      this.videoIndex,
  );

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.module.videoIds[widget.videoIndex],
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    bool existPrevious = true;
    if (widget.videoIndex == 0) {
      existPrevious = false;
    }

    bool existNext = true;
    int lastIndex = widget.module.length - 1;
    if (widget.videoIndex == lastIndex){
      existNext = false;
    }

    // String completion_percent = ((widget.video_index/widget.module.length)*100).toInt().toString() + "% complete";

    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
      ),
      builder: (context, player) => Material(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    width: double.infinity,
                    color: Colors.white, //Color(0xfff6f6f6),
                    padding: EdgeInsets.fromLTRB(30,20,30,20),
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    widget.module.title,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                // Text(completion_percent, style: TextStyle(color: Colors.black, fontSize: 14,),),
                            ],
                          ),
                          IconButton(
                            color: Colors.black,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () => {
                              deactivate(),
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => Learn2()),
                                  (route) => false),
                            },
                          ),
                        ],
                      ),
                    ),
                ),
                player,
                Padding(
                  padding: const EdgeInsets.fromLTRB(30,0,30,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Text(
                          widget.module.videoTitles[widget.videoIndex],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Text(
                          widget.module.videoMinutes[widget.videoIndex],
                          style: TextStyle(
                              fontSize: 16,
                          ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          existPrevious
                            ? Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    _controller.pause();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TutorialPage(
                                          widget.module,
                                          widget.videoIndex - 1,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.blueGrey[100],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Previous", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12)),
                                        SizedBox(height: 3),
                                        Text(
                                            widget.module.videoTitles[widget.videoIndex - 1],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                            widget.module.videoMinutes[widget.videoIndex - 1],
                                            style: TextStyle(color: Colors.black, fontSize: 10)),
                                      ],
                                    ),
                                  ),
                                ),
                              ) : Expanded(child: Container()),
                          SizedBox(width: 10),
                          existNext ?
                          Expanded(
                            child: GestureDetector(
                                onTap: (){
                                  _controller.pause();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TutorialPage(
                                          widget.module,
                                          widget.videoIndex + 1,
                                        ),
                                      ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.blueGrey[100],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Next", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12)),
                                      SizedBox(height: 3),
                                      Text(
                                          widget.module.videoTitles[widget.videoIndex + 1],
                                          style: TextStyle(color: Colors.black, fontSize: 14),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.right,
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                          widget.module.videoMinutes[widget.videoIndex + 1],
                                          style: TextStyle(color: Colors.black, fontSize: 10)
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ) : Expanded(child: Container()),
                        ],
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                  decoration: BoxDecoration(
                    color: Color(0xfff6f6f6),
                    border: Border(
                      top: BorderSide(
                        color: Color(0xffeaeaea),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      "All Module Videos",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      VideoList(
                        widget.module,
                        widget.videoIndex,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Practice quiz",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "10 questions",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_rounded, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      );
  }
}