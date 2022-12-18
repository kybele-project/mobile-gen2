import 'package:flutter/material.dart';
import 'package:kybele_gen2/learn/video_page.dart';
import 'package:kybele_gen2/nav/header.dart';
import 'package:firebase_auth/firebase_auth.dart';


class YouTubeVideoButton3 extends StatelessWidget {

  final Module module;
  final int video_index;

  YouTubeVideoButton3(this.module, this.video_index);


  String fetchThumbnailUrl(String videoId) {
    return "https://img.youtube.com/vi/$videoId/0.jpg";
  }

  @override
  Widget build(BuildContext context) {

    String url = fetchThumbnailUrl(module.video_ids[video_index]);

    return InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TutorialPage(
                  module,
                  video_index,
                )
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: (16/9) * 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child : Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 16/9,
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              alignment: const FractionalOffset(0.5,0.5),
                              image: NetworkImage(url),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 30
                        ),
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
                            module.video_titles[video_index],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                            ),
                        ),
                        Text(
                            module.video_minutes[video_index],
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

  const ModuleVideoList(this.module);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          for (int i = 0; i < module.length; ++i)
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child :YouTubeVideoButton3(module, i),
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

  final String title;
  final int num_videos;
  final int num_quiz;
  final int length;
  final Icon icon;

  const ModuleHeader(this.title, this.num_videos, this.num_quiz, this.length, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20,15,20,15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20
                  ),
              ),
              Text(
                  "$num_videos videos - $length min",
                  style: TextStyle(color: Colors.black, fontSize: 14)
              ),
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
  Module module;
  int color_hex;

  ModuleGroup(
      this.module,
      this.color_hex,
  );

  @override
  _ModuleGroupState createState() => _ModuleGroupState();
}


class _ModuleGroupState extends State<ModuleGroup> {

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Color(widget.color_hex),
            border: Border.all(
                color: Color(0xffeaeaea),
                width: 1,
            ),
        ),

        child: Column(
          children: [
            GestureDetector(
              onTap:() {
                setState(() {
                  widget.isExpanded = !widget.isExpanded;
                });
              },
              child: Column(
                children: [
                  widget.isExpanded ?
                  ModuleHeader(
                    widget.module.title,
                    widget.module.num_videos,
                    widget.module.num_cert_quiz,
                    69,
                    Icon(Icons.expand_less_rounded, color: Colors.black),
                  ) :
                  ModuleHeader(
                    widget.module.title,
                    widget.module.num_videos,
                    widget.module.num_cert_quiz,
                    69,
                    Icon(Icons.expand_more_rounded, color: Colors.black),
                  )
                ],
              ),
            ),
            AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: widget.isExpanded ?
                ModuleVideoList(
                  widget.module,
                ) : Container()
            ),
            // PracticeQuizButton(),
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
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                ),
              ),
            ],
          ),
          Icon(Icons.arrow_forward_rounded, color: Colors.white),
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
                Icon(Icons.emoji_events_rounded, color: Colors.amber[800], size: 24),
                SizedBox(width: 10),
                Text("Certified Midwife",
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
                Text("75% to Certified Midwife Manager",
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

class LearnRoutes {
  static const String learn_root = "/learn/";
  static const String module_root = "/learn/module/";
}

class Learn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              return Column(
                children: [
                  Header(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Learn", style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 36)),
                                SizedBox(height: 10),
                                // CertificationPane(),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ModuleGroup(
                                  Module(
                                    module1_title,
                                    module1_num_videos,
                                    module1_num_cert_quiz,
                                    module1_length,
                                    module1_video_ids,
                                    module1_video_titles,
                                    module1_video_minutes,
                                  ),
                                  0xffffffff,
                                ),
                                SizedBox(height: 30),
                                ModuleGroup(
                                  Module(
                                    module1_title,
                                    module1_num_videos,
                                    module1_num_cert_quiz,
                                    module1_length,
                                    module1_video_ids,
                                    module1_video_titles,
                                    module1_video_minutes,
                                  ),
                                  0xffffffff,
                                ),
                                SizedBox(height: 30),
                                ModuleGroup(
                                  Module(
                                    module1_title,
                                    module1_num_videos,
                                    module1_num_cert_quiz,
                                    module1_length,
                                    module1_video_ids,
                                    module1_video_titles,
                                    module1_video_minutes,
                                  ),
                                  0xffffffff,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}

class LearnRouter extends StatelessWidget {


  static final GlobalKey<NavigatorState> learnKey = GlobalKey();

  Map<String, WidgetBuilder> _learnRouteBuilders(BuildContext context) {
    return {
      LearnRoutes.learn_root: (context) => Learn(),
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
            builder: (context) => routeBuilders[routeSettings.name]!(context)
        );
      },
    );
  }
}











