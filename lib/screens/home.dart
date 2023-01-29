import 'package:flutter/material.dart';
import 'package:kybele_gen2/old/tools/AdditionalResources.dart';
import 'package:kybele_gen2/screens/APGAR3.dart';
import 'package:kybele_gen2/screens/TargetOxygenSaturation2.dart';
import 'package:kybele_gen2/screens/video_page.dart';
import 'package:kybele_gen2/templates/page/page.dart';

import '../components/button.dart';
import '../databases/modules.dart';

class HomePage extends StatelessWidget {

  Widget body(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20,0,20,0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  /*
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/kybele_purple.png',
                      height: 40,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                   */
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Tools",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            SliverGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1,
              children: [
                KybeleColorfulTile(
                  Color(0xffFFCDCF),
                  Color(0xff8B3E42),
                  Icons.calculate_rounded,
                  'APGAR Calculator',
                  APGARCalculator2(),
                ),
                KybeleColorfulTile(
                  Color(0xffE2EEF9),
                  Color(0xff436B8F),
                  Icons.bubble_chart_rounded,
                  'Oxygen Saturation',
                  TargetOxygenSaturation(),
                ),
                KybeleColorfulTile(
                  Color(0xffE2EEF9),
                  Color(0xff436B8F),
                  Icons.bubble_chart_rounded,
                  'Forms',
                  TargetOxygenSaturation(),
                ),
                KybeleColorfulTile(
                  Color(0xffE2EEF9),
                  Color(0xff436B8F),
                  Icons.bubble_chart_rounded,
                  'NRP Algorithm',
                  TargetOxygenSaturation(),
                ),
/*                             KybeleColorfulTile(
                              Color(0xfff9d8b9),
                              Color(0xff9B5717),
                              Icons.account_tree_rounded,
                              'NRP Algorithm',
                              NRPCodedDiagram(),
                            ),
                            KybeleColorfulTile(
                              Color(0xffE2F9E3),
                              Color(0xff69976B),
                              Icons.video_library_rounded,
                              'Training Videos',
                              Learn2(),
                            ), */
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 20),
                Text(
                  "Training Videos",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 10),
              ]),
            ),

            SliverToBoxAdapter(
              child: Container(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap:() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TutorialPage(
                                Video.video_List[index],
                                index,
                              )),
                        );
                      }, child:Container(
                      width: 210.0,
                      margin: EdgeInsets.only(right:40),
                      child: Column(
                          children: [
                            Image.asset(Video.video_List[index].thumbnail_path!),
                            Container(width: 225, child:Text(Video.video_List[index].video_title!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100), textAlign: TextAlign.left,)),
                            Container(width: 225, child:Text("${Video.video_List[index].video_length} mins", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100), textAlign: TextAlign.left,)),
                          ]
                      ),
                    ),
                    );
                  },
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 20),
                Text(
                  "Additional Resources",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 10),
              ]),
            ),
            SliverGrid.count(
                crossAxisCount: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 5,
                children: [
                  KybelePDFTile(
                    "NRP Checklist",
                    RenderScreen(
                      "NRP Checklist",
                      "assets/NRPQuickEquipmentChecklist.pdf",
                    ),
                  ),
                  KybelePDFTile(
                    "A4 NRP Checklist",
                    RenderScreen(
                      "A4 NRP Checklist",
                      "assets/A4 - NRP Checklist 27Oct2022.pdf",
                    ),
                  ),
                  KybelePDFTile(
                    "T-Piece Resuscitator for Lamination",
                    RenderScreen(
                      "T-Piece Resuscitator for Lamination",
                      "assets/T-Piece resuscitator for lamination.pdf",
                    ),
                  ),
                  KybelePDFTile(
                    "Warmilu Thermal Gel Instructions",
                    RenderScreen(
                      "A4 NRP Checklist",
                      "assets/Warmilu_thermal gel autoclave instructions.pdf",
                    ),
                  ),

                ]
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonMenu(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Log event', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const KybeleColorfulButton(Color(0xffFFCDCF), Color(0xff8B3E42), Icons.calculate_rounded, 'APGAR Score', APGARCalculator2()),
          const SizedBox(height: 20),
          const KybeleColorfulButton(Color(0xffE2EEF9), Color(0xff436B8F), Icons.bubble_chart_rounded, 'Oxygen Saturation', TargetOxygenSaturation()),
          const SizedBox(height: 20),
          GestureDetector(onTap: () => {Navigator.pop(context)}, child: const KybeleOutlineButton('Cancel')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KybelePage(
        true,
        true,
        true,
        true,
        false,
        body(context),
        headerText: "Home",
        headerIcon: Icons.home_rounded,
        headerIconBkgColor: Color(0xffdddddd),
        headerIconColor: Color(0xff555555),
        bottomButtonText: "Log event",
        bottomButtonMenuWidget: buttonMenu(context),
    );
  }
}