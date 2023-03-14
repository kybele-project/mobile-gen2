import 'package:flutter/material.dart';
import 'package:kybele_gen2/screens/video_page.dart';
import '../style/colors.dart';
import '../templates/page/page.dart';
import '../databases/modules.dart';

class VideosPages extends StatelessWidget {

  const VideosPages({super.key});

  Widget body() {
    return Expanded(
      child: 
      Container(
        margin: const EdgeInsets.all(15),
        child:
      GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: 2,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                      onTap:() {
                        Navigator.push(
                          ctx,
                          MaterialPageRoute(
                              builder: (context) => TutorialPage(
                                Video.videoList[index],
                                index,
                              )),
                        );
                      },
                      child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child:
                            Image.asset(Video.videoList[index].thumbnailPath!),),
                            SizedBox(width: 225, child:Text(Video.videoList[index].videoTitle!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w100), textAlign: TextAlign.left,)),
                            SizedBox(width: 225, child:Text("${Video.videoList[index].videoLength} mins", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w100), textAlign: TextAlign.left,)),
                          ]
                      ),
                    );
            }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return KybelePage.fixedWithHeader(
      hasHeaderIcon: true,
      hasHeaderClose: true,
      hasBottomActionButton: false,
      bodyWidget: body(),
      headerText: "Videos",
      headerIcon: Icons.ondemand_video_rounded,
      headerIconBkgColor: videoBkgColor,
      headerIconColor: videoIconColor,
    );
  }
}