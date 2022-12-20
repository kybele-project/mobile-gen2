import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'video_library.dart';


String module1_title = "Understanding the Neonata";
int module1_num_videos = 4;
int module1_num_cert_quiz = 1;
int module1_length = 4;

List<String> module1_video_ids = [
  "w3ZHLbLAItw",
  "vrwYUOg1bZQ",
  "KkO-DttA9ew",
  "_1Yj93-RKI8",
];

List<String> module1_video_titles = [
  "House sizes are getting absurd",
  "This Incredible Megastructure Just Failed [Nakagin Capsule Tower]",
  "How Toronto Got Addicted to Cars",
  "USC vs. Utah pregame",
];

List<String> module1_video_minutes = [
  "12 min",
  "13 min",
  "17 min",
  "10 min",
];

class Module {
  final String title;
  final int num_videos;
  final int num_cert_quiz;
  final int length;

  final List<String> video_ids;
  final List<String> video_titles;
  final List<String> video_minutes;

  Module(
      this.title,
      this.num_videos,
      this.num_cert_quiz,
      this.length,
      this.video_ids,
      this.video_titles,
      this.video_minutes,
  );
}

class VideoList extends StatelessWidget {

  final Module module;
  final int ignore_index;

  const VideoList(this.module, this.ignore_index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < module.length; ++i)
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
  final int video_index;

  TutorialPage(
      this.module,
      this.video_index,
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
      initialVideoId: widget.module.video_ids[widget.video_index],
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
    if (widget.video_index == 0) {
      existPrevious = false;
    }

    bool existNext = true;
    int lastIndex = widget.module.length - 1;
    if (widget.video_index == lastIndex){
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
                          widget.module.video_titles[widget.video_index],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Text(
                          widget.module.video_minutes[widget.video_index],
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
                                          widget.video_index - 1,
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
                                            widget.module.video_titles[widget.video_index - 1],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                            widget.module.video_minutes[widget.video_index - 1],
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
                                          widget.video_index + 1,
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
                                          widget.module.video_titles[widget.video_index + 1],
                                          style: TextStyle(color: Colors.black, fontSize: 14),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.right,
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                          widget.module.video_minutes[widget.video_index + 1],
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
                        widget.video_index,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                  decoration: BoxDecoration(
                    color: Colors.blue,
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