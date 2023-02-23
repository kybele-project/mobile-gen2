import 'package:flutter/material.dart';
import 'package:kybele_gen2/screens/APGAR3.dart';
import 'package:kybele_gen2/screens/Manuals.dart';
import 'package:kybele_gen2/screens/TargetOxygenSaturation2.dart';
import 'package:kybele_gen2/screens/video_page.dart';
import 'package:kybele_gen2/screens/Forms.dart';
import 'package:kybele_gen2/screens/Videos.dart';
import 'package:kybele_gen2/screens/nrp_algorithm.dart';
import 'package:kybele_gen2/templates/page/page.dart';

import '../components/button.dart';
import '../databases/modules.dart';
import 'oxygen_saturation.dart';

const List<String> list = <String>["NRP Module"];

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
                  Padding(
                  padding: EdgeInsets.fromLTRB(0,40,0,20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/kybele_purple.png',
                          height: 40,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            color:  Color(0xff7266D7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                            
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Text("NRP MODULE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                        ),
                      ),
                    ],
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
                KybeleAssistantTile
                  (Color(0xff564BAF),
                    Colors.white,
                    Icons.handshake_rounded,
                    "Simulation"
                ),
                KybeleColorfulTile(
                  Color(0xffffe9cc),
                  Color(0xff89683e),
                  Icons.account_tree_rounded,
                  'Algorithm',
                  NRPPages(),
                ),
                KybeleColorfulTile(
                  Color(0xffFFCDCF),
                  Color(0xff8B3E42),
                  Icons.calculate_rounded,
                  'APGAR Score',
                  APGARCalculator2(simVariant: false),
                ),
                KybeleColorfulTile(
                  Color(0xfff6f7d9),
                  Color(0xff8d8e43),
                  Icons.library_books_rounded,
                  'Educational Material/Manuals',
                  ManualsPages(),
                ),
                KybeleColorfulTile(
                  Color(0xffdaf7d9),
                  Color(0xff458e43),
                  Icons.checklist_rtl_rounded,
                  'Forms',
                  FormsPages(),
                ),
                KybeleColorfulTile(
                  Color(0xffE2EEF9),
                  Color(0xff436B8F),
                  Icons.bubble_chart_rounded,
                  'Oxygen Saturation',
                  OxygenSaturation(simVariant: false),
                ),
                KybeleColorfulTile(
                  Color(0xfff9e1f5),
                  Color(0xff8e4383),
                  Icons.ondemand_video_rounded,
                  'Videos',
                  VideosPages(),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  /*
  Widget buttonMenu(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Log event', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const KybeleColorfulButton(Color(0xffFFCDCF), Color(0xff8B3E42), Icons.calculate_rounded, 'APGAR Score', APGARCalculator2(simVariant: true,)),
          const SizedBox(height: 20),
          const KybeleColorfulButton(Color(0xffE2EEF9), Color(0xff436B8F), Icons.bubble_chart_rounded, 'Oxygen Saturation', TargetOxygenSaturation()),
          const SizedBox(height: 20),
          GestureDetector(onTap: () => {Navigator.pop(context)}, child: const KybeleOutlineButton('Cancel')),
        ],
      ),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return KybelePage.fixedNoHeader(
      hasBottomActionButton: false,
      bodyWidget: body(context),
    );
  }
}