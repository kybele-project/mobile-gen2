import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'videogen2.dart';


String module1_title = "lol this is a module";
int module1_num_videos = 2;
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


class TutorialPage extends StatefulWidget {

  final String module_title;
  final int module_num_videos;
  final int module_num_cert_quiz;
  final int module_length;

  final List<String> module_video_ids;
  final List<String> module_video_titles;
  final List<String> module_video_minutes;

  final int video_index;

  TutorialPage(
      this.module_title,
      this.module_num_videos,
      this.module_num_cert_quiz,
      this.module_length,
      this.module_video_ids,
      this.module_video_titles,
      this.module_video_minutes,
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
      initialVideoId: widget.module_video_ids[widget.video_index],
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
    int lastIndex = widget.module_length - 1;
    if (widget.video_index == lastIndex){
      existNext = false;
    }

    String completion_percent = ((widget.video_index/widget.module_length)*100).toInt().toString() + "% complete";

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
                    color: Colors.blue,
                    padding: EdgeInsets.fromLTRB(30,15,30,15),
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    widget.module_title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    completion_percent,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                    ),
                                ),
                            ],
                          ),
                          IconButton(
                            color: Colors.white,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () => {
                              deactivate(),
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => NRPVideos3(),
                                ),
                              ),
                            }
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
                          widget.module_video_titles[widget.video_index],
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 7.5),
                      Text(
                          widget.module_video_minutes[widget.video_index],
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
                                          widget.module_title,
                                          widget.module_num_videos,
                                          widget.module_num_cert_quiz,
                                          widget.module_length,
                                          widget.module_video_ids,
                                          widget.module_video_titles,
                                          widget.module_video_minutes,
                                          widget.video_index - 1,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.grey[400],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("PREVIOUS", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12)),
                                        SizedBox(height: 3),
                                        Text(
                                            widget.module_video_titles[widget.video_index - 1],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                            widget.module_video_minutes[widget.video_index - 1],
                                            style: TextStyle(color: Colors.black, fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                ),
                              ) : Expanded(child: Container()),
                          SizedBox(width: 20),
                          existNext ?
                          Expanded(
                            child: GestureDetector(
                                onTap: (){
                                  _controller.pause();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TutorialPage(
                                          widget.module_title,
                                          widget.module_num_videos,
                                          widget.module_num_cert_quiz,
                                          widget.module_length,
                                          widget.module_video_ids,
                                          widget.module_video_titles,
                                          widget.module_video_minutes,
                                          widget.video_index + 1,
                                        ),
                                      ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.grey[400],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("NEXT", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12)),
                                      SizedBox(height: 3),
                                      Text(
                                          widget.module_video_titles[widget.video_index + 1],
                                          style: TextStyle(color: Colors.black, fontSize: 18),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.right,
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                          widget.module_video_minutes[widget.video_index + 1],
                                          style: TextStyle(color: Colors.black, fontSize: 14)
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ) : Expanded(child: Container()),

                        ],
                      ),
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