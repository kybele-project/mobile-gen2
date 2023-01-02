import 'package:flutter/material.dart';
import 'package:kybele_gen2/learn/modules.dart';
import 'package:kybele_gen2/nav/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class ChewieDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;
  final int selectedIndex = 0;
  static Module selectedModule = ghmpModule;

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

  List<String> srcs = [
    "https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4"
  ];

  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        VideoPlayerController.asset(selectedModule.videoIds[selectedIndex])..addListener((() => {}));
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

    final subtitles = [
      Subtitle(
        index: 0,
        start: Duration.zero,
        end: const Duration(seconds: 10),
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Hello',
              style: TextStyle(color: Colors.red, fontSize: 22),
            ),
            TextSpan(
              text: ' from ',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            TextSpan(
              text: 'subtitles',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            )
          ],
        ),
      ),
      Subtitle(
        index: 0,
        start: const Duration(seconds: 10),
        end: const Duration(seconds: 20),
        text: 'Whats up? :)',
        // text: const TextSpan(
        //   text: 'Whats up? :)',
        //   style: TextStyle(color: Colors.amber, fontSize: 22, fontStyle: FontStyle.italic),
        // ),
      ),
    ];

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: toggleVideo,
            iconData: Icons.live_tv_sharp,
            title: 'Toggle Video Src',
          ),
        ];
      },
      subtitle: Subtitles(subtitles),
      subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ),

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

  int currPlayIndex = 0;

  Future<void> toggleVideo() async {
    await _videoPlayerController1.pause();
    currPlayIndex += 1;
    if (currPlayIndex >= srcs.length) {
      currPlayIndex = 0;
    }
    await initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return 
          Container(height: 300,child:
            Center(
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
              ));
            
  }
}

class YouTubeVideoButton3 extends StatefulWidget {
  final Module module;
  final int videoIndex;

  const YouTubeVideoButton3(this.module, this.videoIndex, {super.key});

  @override
  State<YouTubeVideoButton3> createState() => _YouTubeVideoButton3State();
}


class _YouTubeVideoButton3State extends State<YouTubeVideoButton3> {
  

  String fetchThumbnailUrl(String videoId) {
    return "https://img.youtube.com/vi/$videoId/0.jpg";
  }

  @override
  Widget build(BuildContext context) {
    String url = fetchThumbnailUrl(widget.module.videoIds[widget.videoIndex]);

    return InkWell(
      onTap: () {
          setState(() {
            selectedIndex: widget.videoIndex;
          });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: (16 / 9) * 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            alignment: const FractionalOffset(0.5, 0.5),
                            image: NetworkImage(url),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Icon(Icons.play_arrow_rounded,
                          color: Colors.white, size: 30),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.module.videoTitles[widget.videoIndex],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    widget.module.videoMinutes[widget.videoIndex],
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModuleVideoList extends StatelessWidget {
  final Module module;

  const ModuleVideoList(this.module, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < module.numVideos; ++i)
          Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: YouTubeVideoButton3(module, i),
              ),
              // if (i != (module1_length - 1)) Divider(height: 2, thickness: 2),
            ],
          ),
        SizedBox(height: 5),
      ],
    );
  }
}

class ModuleHeader extends StatelessWidget {
  final Module module;
  final Icon icon;

  const ModuleHeader(this.module, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                module.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
                softWrap: true,
                maxLines: 3,
              ),
              Text(
                module.subtitle,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text("${module.numVideos} videos - ${module.length} min",
                  style: const TextStyle(color: Colors.black, fontSize: 14)),
            ],
          ),
          icon,
        ],
      ),
    );
  }
}

class ModuleGroup extends StatefulWidget {
  bool isExpanded = true;
  final Module module;

  ModuleGroup(
    this.module,
  );

  @override
  _ModuleGroupState createState() => _ModuleGroupState();
}

class _ModuleGroupState extends State<ModuleGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        // border: Border.all(color: Color(0xffeaeaea), width: 1,),
        boxShadow: [
          BoxShadow(
              color: Color(0xccbbbbbb), offset: Offset(0, 3), blurRadius: 5),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.isExpanded = !widget.isExpanded;
                });
              },
              child: Column(
                children: [
                  widget.isExpanded
                      ? ModuleHeader(
                          widget.module,
                          const Icon(Icons.expand_less_rounded,
                              color: Colors.black),
                        )
                      : ModuleHeader(
                          widget.module,
                          const Icon(Icons.expand_more_rounded,
                              color: Colors.black),
                        )
                ],
              ),
            ),
            AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: widget.isExpanded
                    ? Container(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 15),
                        child: ModuleVideoList(
                          widget.module,
                        ))
                    : Container()),
            PracticeQuizButton(),
          ],
        ),
      ),
    );
  }
}

class PracticeQuizButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
      decoration: const BoxDecoration(
        color: Colors.teal,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Practice quiz",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_rounded, color: Colors.white),
        ],
      ),
    );
  }
}

class CertificationPane extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.emoji_events_rounded,
                color: Colors.amber[800], size: 24),
            SizedBox(width: 10),
            Text(
              "Certified Midwife",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.trending_up_rounded, color: Colors.green, size: 24),
            SizedBox(width: 10),
            Text(
              "75% to Certified Midwife Manager",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Learn2 extends StatelessWidget {
  Widget tealContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          // teal
          colors: [
            Color(0xff005660),
            Color(0xff007475),
            Color(0xff008081),
            Color(0xff229389),
            Color(0xff34A798),
            Color(0xff57C3AD),
          ],
          // sunset
          // colors: [Color(0xff7d2c4c), Color(0xffac3d63), Color(0xffca4a67), Color(0xffe55a59),],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double side = (MediaQuery.of(context).size.width - 60) / 2;
    double begin = MediaQuery.of(context).size.width / 1.5 - side / 2;

    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PopUpHeader(
              'Videos',
              Icon(
                Icons.video_collection_sharp,
                color: Colors.deepPurpleAccent[100],
                size: 30,
              ),
            ),
                
                SingleChildScrollView( child:
                Column( children:[
                  ChewieDemo(),
                  

                  Container(child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ModuleGroup(garhModule),
                        SizedBox(height: 30),
                        ModuleGroup(ghmpModule),
                      ],
                    ),
                  ),
                  
                ]
                )
                )
          ]))));       
  }
}

class LearnRoutes {
  static const String learn_root = "/learn/";
  static const String module_root = "/learn/module/";
}

class LearnRouter extends StatelessWidget {
  static final GlobalKey<NavigatorState> learnKey = GlobalKey();

  Map<String, WidgetBuilder> _learnRouteBuilders(BuildContext context) {
    return {
      LearnRoutes.learn_root: (context) => Learn2(),
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _learnRouteBuilders(context);

    return Navigator(
      key: learnKey,
      initialRoute: LearnRoutes.learn_root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context));
      },
    );
  }
}
