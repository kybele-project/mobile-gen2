import 'package:kybele_gen2/nav/header.dart';
import 'dart:io';
import 'package:kybele_gen2/learn/modules.dart';
import 'package:kybele_gen2/learn/video_page.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

class YouTubeVideoButton3 extends StatelessWidget {
  final Module module;
  final int videoIndex;

  const YouTubeVideoButton3(this.module, this.videoIndex, {super.key});

  String fetchThumbnailUrl(String videoId) {
    return "https://img.youtube.com/vi/$videoId/0.jpg";
  }

  @override
  Widget build(BuildContext context) {
    String url = fetchThumbnailUrl(module.videoIds[videoIndex]);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TutorialPage(
                    module,
                    videoIndex,
                  )),
        );
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
                    module.videoTitles[videoIndex],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    module.videoMinutes[videoIndex],
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
  @override
  Widget build(BuildContext context) {
    double side = (MediaQuery.of(context).size.width - 60) / 2;
    double begin = MediaQuery.of(context).size.width / 1.5 - side / 2;

    return
    Material(
      child: SafeArea(
        child: Column(
          children: [
            PopUpHeader(
              'Videos',
              Icon(
                Icons.video_collection_sharp,
      color: Colors.pinkAccent,
      size: 30,
              ),
            ),
            Expanded(child:SingleChildScrollView(child:
            Column(children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ModuleGroup(garhModule),
                        SizedBox(height: 30),
                        ModuleGroup(ghmpModule),
                      ],
                    ),
                  )])))]),));
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