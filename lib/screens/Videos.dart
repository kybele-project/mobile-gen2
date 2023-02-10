import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/timeline.dart';
import 'package:kybele_gen2/screens/APGAR3.dart';
import 'package:kybele_gen2/screens/TargetOxygenSaturation2.dart';
import 'package:kybele_gen2/screens/video_page.dart';
import '../components/button.dart';
import '../templates/page/page.dart';
import '../databases/modules.dart';

class VideosPages extends StatelessWidget {

  Widget body() {
    return Expanded(
      child: 
      Container(
        margin: EdgeInsets.all(15),
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
                                Video.video_List[index],
                                index,
                              )),
                        );
                      }, child:Container(
                      child: Column(
                          children: [
                            ClipRRect(
    borderRadius: BorderRadius.circular(4.0),
    child:
                            Image.asset(Video.video_List[index].thumbnail_path!),),
                            Container(width: 225, child:Text(Video.video_List[index].video_title!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100), textAlign: TextAlign.left,)),
                            Container(width: 225, child:Text("${Video.video_List[index].video_length} mins", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100), textAlign: TextAlign.left,)),
                          ]
                      ),
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
      headerIconBkgColor: Color(0xfff9e1f5),
      headerIconColor: Color(0xff8e4383),
    );
  }
}