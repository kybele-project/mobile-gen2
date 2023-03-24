import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/buttons/buttons.dart';
import 'package:kybele_gen2/components/scaffold/scaffold.dart';
import 'package:kybele_gen2/main.dart';
import 'package:kybele_gen2/style/style.dart';

import 'apgar.dart';
import 'nrp_forms.dart';
import 'nrp_manuals.dart';
import 'nrp_algorithm.dart';
import 'record.dart';
import 'tables.dart';
import 'videos.dart';

class NRPHome extends StatelessWidget {
  const NRPHome({super.key});

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
                      const SizedBox(height: 20),
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
                      page: const Framework(
                          child: APGARCalculator2(simVariant: false)),
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
                      page: const Framework(child: NRPManuals()),
                    ),
                    KTile(
                      bkgColor: formsBkgColor,
                      labelColor: formsIconColor,
                      iconData: formsIcon,
                      header: 'Forms',
                      page: const Framework(child: NRPForms()),
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
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold.fixedWithHeader(
        hasHeaderIcon: true,
        headerIcon: Icons.backpack_rounded,
        headerIconColor: Colors.white,
        headerIconBkgColor: mainMediumPurple,
        hasHeaderClose: true,
        hasBottomActionButton: false,
        headerText: "NRP Module",
        bodyWidget: body(context),
    );
  }
}
