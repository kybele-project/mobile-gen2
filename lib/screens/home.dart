import 'package:flutter/material.dart';
import 'package:kybele_gen2/screens/apgar.dart';
import 'package:kybele_gen2/screens/manuals.dart';
import 'package:kybele_gen2/screens/forms.dart';
import 'package:kybele_gen2/screens/videos.dart';
import 'package:kybele_gen2/screens/nrp_algorithm.dart';
import 'package:kybele_gen2/screens/tables.dart';
import 'package:kybele_gen2/templates/page/page.dart';

import '../components/buttons/buttons.dart';
import '../main.dart';
import '../style/colors.dart';
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
                            color:  mainMediumPurple,
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
              children: [
                KybeleAssistantTile(
                    mainDarkPurple,
                    Colors.white,
                    Icons.handshake_rounded,
                    "Simulation"
                ),
                KybeleColorfulTile(
                  algorithmBkgColor,
                  algorithmIconColor,
                  Icons.account_tree_rounded,
                  'Algorithm',
                  const Framework(child: NRPPages()),
                ),
                KybeleColorfulTile(
                  apgarBkgColor,
                  apgarIconColor,
                  Icons.calculate_rounded,
                  'APGAR Score',
                  const Framework(child: APGARCalculator2(simVariant: false)),
                ),
                KybeleColorfulTile(
                  manualsBkgColor,
                  manualsIconColor,
                  Icons.library_books_rounded,
                  'Educational Material/Manuals',
                  const Framework(child: ManualsPages()),
                ),
                KybeleColorfulTile(
                  formsBkgColor,
                  formsIconColor,
                  Icons.checklist_rtl_rounded,
                  'Forms',
                  const Framework(child: FormsPages()),
                ),
                KybeleColorfulTile(
                  oxygenSatBkgColor,
                  oxygenSatIconColor,
                  Icons.bubble_chart_rounded,
                  'Oxygen Saturation',
                  const Framework(child: OxygenSaturation(simVariant: false)),
                ),
                KybeleColorfulTile(
                  videoBkgColor,
                  videoIconColor,
                  Icons.ondemand_video_rounded,
                  'Videos',
                  const Framework(child: VideosPages()),
                ),
                KybeleColorfulTile(
                  tablesBkgColor,
                  tablesIconColor,
                  Icons.dataset_rounded,
                  'Tables',
                  const Framework(child: TablesPages()),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 20),
                  const Text("Powered by ClinicPal, LLC"),
                  const SizedBox(height: 40),
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