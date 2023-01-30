import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/timeline.dart';
import 'package:kybele_gen2/screens/APGAR3.dart';
import 'package:kybele_gen2/screens/TargetOxygenSaturation2.dart';
import 'package:kybele_gen2/old/tools/AdditionalResources.dart';
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
            itemCount: 5,
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
                            Image.asset(Video.video_List[index].thumbnail_path!),
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
    return KybelePage(
      false,
      true,
      true,
      true,
      false,
      body(),
      headerText: "Videos",
      headerIcon: Icons.list_alt_rounded,
      headerIconBkgColor: Color.fromARGB(255, 221, 221, 221),
      headerIconColor: Color.fromARGB(255, 239, 66, 255),
    );
  }
}