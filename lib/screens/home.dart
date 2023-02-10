import 'package:flutter/material.dart';
import 'package:kybele_gen2/screens/APGAR3.dart';
import 'package:kybele_gen2/screens/TargetOxygenSaturation2.dart';
import 'package:kybele_gen2/screens/video_page.dart';
import 'package:kybele_gen2/screens/Forms.dart';
import 'package:kybele_gen2/screens/Videos.dart';
import 'package:kybele_gen2/screens/nrp_algorithm.dart';
import 'package:kybele_gen2/templates/page/page.dart';

import '../components/button.dart';
import '../databases/modules.dart';
import 'oxygen_saturation.dart';

const List<String> list = <String>["NRP Module                                        "];

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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/kybele_purple.png',
                      height: 40,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
              SizedBox(height: 20),
/*                   Container( width: 50, child:
                  DropdownButton<String>(
      value: "NRP Module                                        ",
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurpleAccent, fontSize: 22, fontWeight: FontWeight.w300),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    )),
    SizedBox(height: 10) */
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
                  'APGAR Score',
                  APGARCalculator2(),
                ),
                KybeleColorfulTile(
                  Color(0xffE2EEF9),
                  Color(0xff436B8F),
                  Icons.bubble_chart_rounded,
                  'Oxygen Saturation',
                  OxygenSaturation(),
                ),
                KybeleColorfulTile(
                  Color(0xffffe9cc),
                  Color(0xff89683e),
                  Icons.account_tree_rounded,
                  'NRP Modules',
                  NRPPages(),
                ),
                KybeleColorfulTile(
                  Color(0xffdaf7d9),
                  Color(0xff458e43),
                  Icons.feed_outlined,
                  'Forms',
                  FormsPages(),
                ),
                KybeleColorfulTile(
                  Color(0xfff9e1f5),
                  Color(0xff8e4383),
                  Icons.ondemand_video_rounded,
                  'Videos',
                  VideosPages(),
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
    return KybelePage.fixedNoHeader(
      hasBottomActionButton: false,
      bodyWidget: body(context),
    );
  }
}