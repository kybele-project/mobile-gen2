import 'package:flutter/material.dart';
import 'package:kybele_gen2/screens/apgar.dart';
import 'package:kybele_gen2/screens/manuals.dart';
import 'package:kybele_gen2/screens/forms.dart';
import 'package:kybele_gen2/screens/videos.dart';
import 'package:kybele_gen2/screens/nrp_algorithm.dart';
import 'package:kybele_gen2/screens/tables.dart';
import 'package:kybele_gen2/templates/page/page.dart';

import '../components/button.dart';
import '../main.dart';
import 'oxygen_saturation.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

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
                  padding: const EdgeInsets.fromLTRB(0,40,0,20),
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
                            color:  const Color(0xff7266D7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                            
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: const Text("NRP MODULE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
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
              children: const [
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
                  Framework(child: NRPPages()),
                ),
                KybeleColorfulTile(
                  Color(0xffFFCDCF),
                  Color(0xff8B3E42),
                  Icons.calculate_rounded,
                  'APGAR Score',
                  Framework(child: APGARCalculator2(simVariant: false)),
                ),
                KybeleColorfulTile(
                  Color(0xfff6f7d9),
                  Color(0xff8d8e43),
                  Icons.library_books_rounded,
                  'Educational Material/Manuals',
                  Framework(child: ManualsPages()),
                ),
                KybeleColorfulTile(
                  Color(0xffdaf7d9),
                  Color(0xff458e43),
                  Icons.checklist_rtl_rounded,
                  'Forms',
                  Framework(child: FormsPages()),
                ),
                KybeleColorfulTile(
                  Color(0xffE2EEF9),
                  Color(0xff436B8F),
                  Icons.bubble_chart_rounded,
                  'Oxygen Saturation',
                  Framework(child: OxygenSaturation(simVariant: false)),
                ),
                KybeleColorfulTile(
                  Color(0xfff9e1f5),
                  Color(0xff8e4383),
                  Icons.ondemand_video_rounded,
                  'Videos',
                  Framework(child: VideosPages()),
                ),
                KybeleColorfulTile(
                  Color(0xffe1f9f8),
                  Color(0xff438e89),
                  Icons.dataset_rounded,
                  'Tables',
                  Framework(child: TablesPages()),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 40)
              ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KybelePage.fixedNoHeader(
      hasBottomActionButton: false,
      bodyWidget: body(context),
    );
  }
}