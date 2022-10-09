import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

const List<String> ds = [
  'uuP-TmIBIfk', //NRP GARH Video Term Baby
  'jwnkRmzsiEg', //NRP GARH Video Preterm Baby
  'v92u23ZZOho', //NRP Endotrachial Intubation
  'aAlMreEBKYU', //NRP Positive Pressure Ventilation with Face Mask
  '0clo9Lvpv7Y', //Helping Babies Breathe at Birth - Newborn Care Series
  'ne06nPIKTmE', //Danger Signs in Newborns, for health workers - Newborn Care Series
  'Wg-k-BlG0r0', //Warning Signs in Newborns, for mother and caregivers - Newborn Care Series
];

class NRPVideos extends StatefulWidget {
  @override
  State<NRPVideos> createState() => _NRPVideosState();
}

class _NRPVideosState extends State<NRPVideos> {
  late YoutubePlayerController controller1;
  late YoutubePlayerController controller2;
  late YoutubePlayerController controller3;
  late YoutubePlayerController controller4;
  late YoutubePlayerController controller5;
  late YoutubePlayerController controller6;
  late YoutubePlayerController controller7;

  @override
  void initState() {
    super.initState();

    const url1 = 'https://www.youtube.com/watch?v=uuP-TmIBIfk';
    const url2 = 'https://www.youtube.com/watch?v=jwnkRmzsiEg';
    const url3 = 'https://www.youtube.com/watch?v=v92u23ZZOho';
    const url4 = 'https://www.youtube.com/watch?v=aAlMreEBKYU';
    const url5 = 'https://www.youtube.com/watch?v=0clo9Lvpv7Y';
    const url6 = 'https://www.youtube.com/watch?v=ne06nPIKTmE';
    const url7 = 'https://www.youtube.com/watch?v=Wg-k-BlG0r0';

    controller1 = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url1)!,
      flags: const YoutubePlayerFlags(
        mute: false,
        loop: false,
        autoPlay: false,
      )
    );

    controller2 = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url2)!,
        flags: const YoutubePlayerFlags(
          mute: false,
          loop: false,
          autoPlay: false,
        )
    );

    controller3 = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url3)!,
        flags: const YoutubePlayerFlags(
          mute: false,
          loop: false,
          autoPlay: false,
        )
    );

    controller4 = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url4)!,
        flags: const YoutubePlayerFlags(
          mute: false,
          loop: false,
          autoPlay: false,
        )
    );

    controller5 = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url5)!,
        flags: const YoutubePlayerFlags(
          mute: false,
          loop: false,
          autoPlay: false,
        )
    );

    controller6 = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url6)!,
        flags: const YoutubePlayerFlags(
          mute: false,
          loop: false,
          autoPlay: false,
        )
    );

    controller7 = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url7)!,
        flags: const YoutubePlayerFlags(
          mute: false,
          loop: false,
          autoPlay: false,
        )
    );
  }

  @override
  void deactivate() {
    controller1.pause();
    controller2.pause();
    controller3.pause();
    controller4.pause();
    controller5.pause();
    controller6.pause();
    controller7.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
    controller7.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) => Material(
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(alignment: Alignment.centerLeft, child: GestureDetector(child: Icon(Icons.arrow_circle_left, size: 32, color: Color(0xFF7B212D)), onTap: Navigator.of(context).pop)),
                      SizedBox(width: 20),
                      Text("Training Videos", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 1,
                    child: Column(
                      children: [
                        YoutubePlayer(
                          controller: controller1,
                        ),
                        ListTile(
                          title: Text("GARH Video Term Baby"),
                          subtitle: Text("Neonatal Resuscitation Program"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 1,
                    child: Column(
                      children: [
                        YoutubePlayer(
                          controller: controller2,
                        ),
                        ListTile(
                          title: Text("GARH Video Preterm Baby"),
                          subtitle: Text("Neonatal Resuscitation Program"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 1,
                    child: Column(
                      children: [
                        YoutubePlayer(
                          controller: controller3,
                        ),
                        ListTile(
                          title: Text("Endotrachial Intubation"),
                          subtitle: Text("Neonatal Resuscitation Program"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 1,
                    child: Column(
                      children: [
                        YoutubePlayer(
                          controller: controller4,
                        ),
                        ListTile(
                          title: Text("Positive Pressure Ventilation with Face Mask"),
                          subtitle: Text("Neonatal Resuscitation Program"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 1,
                    child: Column(
                      children: [
                        YoutubePlayer(
                          controller: controller5,
                        ),
                        ListTile(
                          title: Text("Helping Babies Breathe"),
                          subtitle: Text("Newborn Care Series"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 1,
                    child: Column(
                      children: [
                        YoutubePlayer(
                          controller: controller6,
                        ),
                        ListTile(
                          title: Text("Danger Signs in Newborns, for health workers"),
                          subtitle: Text("Newborn Care Series"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 1,
                    child: Column(
                      children: [
                        YoutubePlayer(
                          controller: controller7,
                        ),
                        ListTile(
                          title: Text("Warning Signs in Newborns, for mother and caregivers"),
                          subtitle: Text("Newborn Care Series"),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            )
          ]

        )

      )
    )
  );
}

