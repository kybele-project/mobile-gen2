import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/buttons/buttons.dart';
import 'package:kybele_gen2/components/scaffold/scaffold.dart';
import 'package:kybele_gen2/main.dart';
import 'package:kybele_gen2/style/style.dart';

import 'apgar.dart';
import 'forms.dart';
import 'manuals.dart';
import 'nrp_algorithm.dart';
import 'record.dart';
import 'tables.dart';
import 'videos.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget body(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/kybele_purple.png',
                                height: 45,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: mainMediumPurple,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                child: const Text("NRP MODULE",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverGrid.count(
                  crossAxisCount: (orientation == Orientation.portrait) ? 2 : 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1,
                  children: [
                    KTile(
                      bkgColor: mainDarkPurple,
                      labelColor: Colors.white,
                      iconData: simulationIcon,
                      header: "Simulation",
                      page: const Framework(child: RecordPages()),
                    ),
                    KTile(
                      bkgColor: apgarBkgColor,
                      labelColor: apgarIconColor,
                      iconData: apgarIcon,
                      header: 'APGAR Score',
                      page: const Framework(child: APGARCalculator2(simVariant: false)),
                    ),
                    KTile(
                      bkgColor: algorithmBkgColor,
                      labelColor: algorithmIconColor,
                      iconData: algorithmIcon,
                      header: 'NRP Algorithm',
                      page: const Framework(child: NRPPages()),
                    ),
                    KTile(
                      bkgColor: tablesBkgColor,
                      labelColor: tablesIconColor,
                      iconData: tablesIcon,
                      header: 'NRP Tables',
                      page: const Framework(child: TablesPages()),
                    ),
                    KTile(
                      bkgColor: manualsBkgColor,
                      labelColor: manualsIconColor,
                      iconData: manualsIcon,
                      header: 'Educational Manuals',
                      page: const Framework(child: Manuals()),
                    ),
                    KTile(
                      bkgColor: formsBkgColor,
                      labelColor: formsIconColor,
                      iconData: formsIcon,
                      header: 'Forms',
                      page: const Framework(child: Forms()),
                    ),
                    KTile(
                      bkgColor: videoBkgColor,
                      labelColor: videoIconColor,
                      iconData: videosIcon,
                      header: 'Videos',
                      page: const Framework(child: Videos()),
                    ),

                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(height: 20),
                      const Text("Powered by ClinicPal, LLC", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                      Text("Made with ❤️ in the USA", style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold.fixedNoHeader(
      hasBottomActionButton: false,
      bodyWidget: body(context),
    );
  }
}