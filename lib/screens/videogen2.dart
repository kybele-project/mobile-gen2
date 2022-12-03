import 'package:flutter/material.dart';
import 'package:kybele_gen2/screens/NRPVideos2.dart';

class YouTubeVideoButton extends StatelessWidget {

  String id;
  String title;
  String length;

  YouTubeVideoButton(this.id, this.title, this.length, {super.key});

  String fetchThumbnailUrl(String videoId) {
    return "https://img.youtube.com/vi/$videoId/0.jpg";
  }

  @override
  Widget build(BuildContext context) {

    String url = fetchThumbnailUrl(id);

    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: AspectRatio(
                  aspectRatio: 16/9,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        alignment: const FractionalOffset(0.5,0.5),
                        image: NetworkImage(url),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(length),
                              ],
                            ),
                            Icon(Icons.play_arrow_rounded, color: Colors.black),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
        ),
    );
  }
}

class YouTubeVideoButton2 extends StatelessWidget {

  String id;
  String title;
  String length;

  YouTubeVideoButton2(this.id, this.title, this.length, {super.key});

  String fetchThumbnailUrl(String videoId) {
    return "https://img.youtube.com/vi/$videoId/0.jpg";
  }

  @override
  Widget build(BuildContext context) {

    String url = fetchThumbnailUrl(id);

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: 16/9,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      alignment: const FractionalOffset(0.5,0.5),
                      image: NetworkImage(url),
                    )
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(length),
                      ],
                    ),
                    Icon(Icons.play_arrow_rounded, color: Colors.black),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CategoryButton extends StatelessWidget {

  final TutorialPage tutorialPage;

  CategoryButton(
      this.tutorialPage,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => tutorialPage
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(this.tutorialPage.module_title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
                    Text(this.tutorialPage.module_length.toString() + " videos - 46 min", style: TextStyle(color: Colors.white)),
                    Text(this.tutorialPage.module_num_cert_quiz.toString() + " certification quiz", style: TextStyle(color: Colors.white)),
                  ],
                ),
                Icon(Icons.playlist_play_rounded, color: Colors.white),
              ],
            ),
        ),
      ),
    );
  }
}


class NRPVideos3 extends StatelessWidget {
  const NRPVideos3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Container(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Learn", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
                        SizedBox(height: 30),
                        CategoryButton(
                          TutorialPage(
                            module1_title,
                            module1_num_videos,
                            module1_num_cert_quiz,
                            module1_length,
                            module1_video_ids,
                            module1_video_titles,
                            module1_video_minutes,
                            0,
                          ),
                        ),
                        SizedBox(height: 15),
                        CategoryButton(
                          TutorialPage(
                            module1_title,
                            module1_num_videos,
                            module1_num_cert_quiz,
                            module1_length,
                            module1_video_ids,
                            module1_video_titles,
                            module1_video_minutes,
                            0,
                          ),
                        ),
                        SizedBox(height: 15),
                        CategoryButton(
                          TutorialPage(
                            module1_title,
                            module1_num_videos,
                            module1_num_cert_quiz,
                            module1_length,
                            module1_video_ids,
                            module1_video_titles,
                            module1_video_minutes,
                            0,
                          ),
                        ),
                      ],
                    ),
                  ),
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Category 1", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24)),
                              Text("3 videos - 46 min", style: TextStyle(color: Colors.white, fontSize: 16)),
                              Text("1 certificaiton quiz", style: TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                          Icon(Icons.playlist_play_rounded, color: Colors.white, size: 36),
                        ],
                      ),
                      SizedBox(height: 30),
                      YouTubeVideoButton2("dCZRlREAwiA", "This is a Massive Test", "8 min"),
                      SizedBox(height: 30),
                      YouTubeVideoButton("dCZRlREAwiA", "This is a Massive Test", "8 min"),
                      SizedBox(height: 30),
                      YouTubeVideoButton("dCZRlREAwiA", "This is a Massive Test", "8 min"),
                      SizedBox(height: 30),
                      YouTubeVideoButton("dCZRlREAwiA", "This is a Massive Test", "8 min"),
                      SizedBox(height: 30),
                      YouTubeVideoButton("dCZRlREAwiA", "This is a Massive Test", "8 min"),
                      SizedBox(height: 30),
                      YouTubeVideoButton("dCZRlREAwiA", "This is a Massive Test", "8 min"),
                    ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                ),
                child: Column(
                  children: [
                    YouTubeVideoButton("dCZRlREAwiA", "This is a Massive Test", "8 min"),
                    SizedBox(height: 30),
                    YouTubeVideoButton("dCZRlREAwiA", "This is a Massive Test", "8 min"),
                    SizedBox(height: 30),
                    YouTubeVideoButton("dCZRlREAwiA", "This is a Massive Test", "8 min"),
                    SizedBox(height: 30),
                    YouTubeVideoButton("dCZRlREAwiA", "This is a Massive Test", "8 min"),
                    SizedBox(height: 30),
                    YouTubeVideoButton("dCZRlREAwiA", "This is a Massive Test", "8 min"),
                    SizedBox(height: 30),
                    YouTubeVideoButton("dCZRlREAwiA", "This is a Massive Test", "8 min"),
                  ],
                ),
              ),
              ],
            ),
          ),
        ),
    );
  }
}

