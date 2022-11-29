import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Text("Category 1", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
                    Text("3 videos - 46 min", style: TextStyle(color: Colors.white)),
                    Text("1 certification quiz", style: TextStyle(color: Colors.white)),
                  ],
                ),
                Icon(Icons.playlist_play_rounded, color: Colors.white),
              ],
            ),
        ),
      );
  }
}

// dimensions scalar*10, scalar*8
class GhanaPinwheel extends CustomClipper<Path> {
  double topLeftHori;
  double topLeftVert;
  double scalar;

  GhanaPinwheel(this.topLeftHori, this.topLeftVert, this.scalar);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addPolygon([
      Offset(topLeftHori, topLeftVert),
      Offset(topLeftHori + scalar*1, topLeftVert),
      Offset(topLeftHori + scalar*1, topLeftVert + scalar*1),
      Offset(topLeftHori + scalar*2, topLeftVert + scalar*1),
      Offset(topLeftHori + scalar*2, topLeftVert + scalar*2),
      Offset(topLeftHori + scalar*3, topLeftVert + scalar*2),
      Offset(topLeftHori + scalar*3, topLeftVert + scalar*3),
      Offset(topLeftHori + scalar*4, topLeftVert + scalar*3),
      Offset(topLeftHori + scalar*4, topLeftVert + scalar*4),
      Offset(topLeftHori, topLeftVert + scalar*4),
    ], true);
    path.addPolygon([
      Offset(topLeftHori + scalar*5,topLeftVert + scalar*4),
      Offset(topLeftHori + scalar*5,topLeftVert),
      Offset(topLeftHori + scalar*9,topLeftVert),
      Offset(topLeftHori + scalar*9,topLeftVert + scalar*1),
      Offset(topLeftHori + scalar*8,topLeftVert + scalar*1),
      Offset(topLeftHori + scalar*8,topLeftVert + scalar*2),
      Offset(topLeftHori + scalar*7,topLeftVert + scalar*2),
      Offset(topLeftHori + scalar*7,topLeftVert + scalar*3),
      Offset(topLeftHori + scalar*6,topLeftVert + scalar*3),
      Offset(topLeftHori + scalar*6,topLeftVert + scalar*4),
    ], true);

    path.addPolygon([
      Offset(topLeftHori + scalar*4, topLeftVert + scalar*4),
      Offset(topLeftHori + scalar*5, topLeftVert + scalar*4),
      Offset(topLeftHori + scalar*5, topLeftVert + scalar*8),
      Offset(topLeftHori + scalar*1, topLeftVert + scalar*8),
      Offset(topLeftHori + scalar*1, topLeftVert + scalar*7),
      Offset(topLeftHori + scalar*2, topLeftVert + scalar*7),
      Offset(topLeftHori + scalar*2, topLeftVert + scalar*6),
      Offset(topLeftHori + scalar*3, topLeftVert + scalar*6),
      Offset(topLeftHori + scalar*3, topLeftVert + scalar*5),
      Offset(topLeftHori + scalar*4, topLeftVert + scalar*5),
    ], true);
    path.addPolygon([
      Offset(topLeftHori + scalar*6, topLeftVert + scalar*4),
      Offset(topLeftHori + scalar*10, topLeftVert + scalar*4),
      Offset(topLeftHori + scalar*10, topLeftVert + scalar*8),
      Offset(topLeftHori + scalar*9, topLeftVert + scalar*8),
      Offset(topLeftHori + scalar*9, topLeftVert + scalar*7),
      Offset(topLeftHori + scalar*8, topLeftVert + scalar*7),
      Offset(topLeftHori + scalar*8, topLeftVert + scalar*6),
      Offset(topLeftHori + scalar*7, topLeftVert + scalar*6),
      Offset(topLeftHori + scalar*7, topLeftVert + scalar*5),
      Offset(topLeftHori + scalar*6, topLeftVert + scalar*5),
    ], true);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}


class GhanaPinWheels extends CustomClipper<Path> {

  GhanaPinWheels();

  Path addGhanaPinwheel(double topLeftHori, double topLeftVert, scalar) {
    Path path = Path();
    path.addPolygon([
      Offset(topLeftHori, topLeftVert),
      Offset(topLeftHori + scalar*1, topLeftVert),
      Offset(topLeftHori + scalar*1, topLeftVert + scalar*1),
      Offset(topLeftHori + scalar*2, topLeftVert + scalar*1),
      Offset(topLeftHori + scalar*2, topLeftVert + scalar*2),
      Offset(topLeftHori + scalar*3, topLeftVert + scalar*2),
      Offset(topLeftHori + scalar*3, topLeftVert + scalar*3),
      Offset(topLeftHori + scalar*4, topLeftVert + scalar*3),
      Offset(topLeftHori + scalar*4, topLeftVert + scalar*4),
      Offset(topLeftHori, topLeftVert + scalar*4),
    ], true);
    path.addPolygon([
      Offset(topLeftHori + scalar*5,topLeftVert + scalar*4),
      Offset(topLeftHori + scalar*5,topLeftVert),
      Offset(topLeftHori + scalar*9,topLeftVert),
      Offset(topLeftHori + scalar*9,topLeftVert + scalar*1),
      Offset(topLeftHori + scalar*8,topLeftVert + scalar*1),
      Offset(topLeftHori + scalar*8,topLeftVert + scalar*2),
      Offset(topLeftHori + scalar*7,topLeftVert + scalar*2),
      Offset(topLeftHori + scalar*7,topLeftVert + scalar*3),
      Offset(topLeftHori + scalar*6,topLeftVert + scalar*3),
      Offset(topLeftHori + scalar*6,topLeftVert + scalar*4),
    ], true);

    path.addPolygon([
      Offset(topLeftHori + scalar*4, topLeftVert + scalar*4),
      Offset(topLeftHori + scalar*5, topLeftVert + scalar*4),
      Offset(topLeftHori + scalar*5, topLeftVert + scalar*8),
      Offset(topLeftHori + scalar*1, topLeftVert + scalar*8),
      Offset(topLeftHori + scalar*1, topLeftVert + scalar*7),
      Offset(topLeftHori + scalar*2, topLeftVert + scalar*7),
      Offset(topLeftHori + scalar*2, topLeftVert + scalar*6),
      Offset(topLeftHori + scalar*3, topLeftVert + scalar*6),
      Offset(topLeftHori + scalar*3, topLeftVert + scalar*5),
      Offset(topLeftHori + scalar*4, topLeftVert + scalar*5),
    ], true);
    path.addPolygon([
      Offset(topLeftHori + scalar*6, topLeftVert + scalar*4),
      Offset(topLeftHori + scalar*10, topLeftVert + scalar*4),
      Offset(topLeftHori + scalar*10, topLeftVert + scalar*8),
      Offset(topLeftHori + scalar*9, topLeftVert + scalar*8),
      Offset(topLeftHori + scalar*9, topLeftVert + scalar*7),
      Offset(topLeftHori + scalar*8, topLeftVert + scalar*7),
      Offset(topLeftHori + scalar*8, topLeftVert + scalar*6),
      Offset(topLeftHori + scalar*7, topLeftVert + scalar*6),
      Offset(topLeftHori + scalar*7, topLeftVert + scalar*5),
      Offset(topLeftHori + scalar*6, topLeftVert + scalar*5),
    ], true);

    return path;
  }


  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addPath(addGhanaPinwheel(0, 0, 10), Offset(0, 0));
    path.addPath(addGhanaPinwheel(10, 0, 10), Offset(0, 0));
    path.addPath(addGhanaPinwheel(20, 0, 10), Offset(0, 0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
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
              Stack(
                children: [
                  ClipPath(
                    clipper: GhanaPinwheels(),
                    child: Container(
                      color: Colors.grey[200],
                      height: 600,
                    ),
                  ),

                  Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Learn", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
                        SizedBox(height: 30),
                        CategoryButton(),
                        SizedBox(height: 15),
                        CategoryButton(),
                        SizedBox(height: 15),
                        CategoryButton(),
                      ],
                    ),
                  ),
                ],
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