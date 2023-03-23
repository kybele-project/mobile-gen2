import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/scaffold/scaffold.dart';
import 'package:kybele_gen2/metadata/assets_metadata.dart';
import 'package:kybele_gen2/screens/nrp_module/video_page.dart';
import 'package:kybele_gen2/style/style.dart';

class Videos extends StatelessWidget {
  const Videos({super.key});

  Widget body() {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(15),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: 2,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  ctx,
                  MaterialPageRoute(
                      builder: (context) => TutorialPage(
                            videoList[index],
                            index,
                          )),
                );
              },
              child: Column(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.asset(videoList[index].thumbnailPath),
                ),
                SizedBox(
                    width: 225,
                    child: Text(
                      videoList[index].title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w100),
                      textAlign: TextAlign.left,
                    )),
                SizedBox(
                    width: 225,
                    child: Text(
                      "${videoList[index].videoLength} mins",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w100),
                      textAlign: TextAlign.left,
                    )),
              ]),
            );
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold.fixedWithHeader(
      hasHeaderIcon: true,
      hasHeaderClose: true,
      hasBottomActionButton: false,
      bodyWidget: body(),
      headerText: "Videos",
      headerIcon: videosIcon,
      headerIconBkgColor: videoBkgColor,
      headerIconColor: videoIconColor,
    );
  }
}
