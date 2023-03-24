import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/buttons/buttons.dart';
import 'package:kybele_gen2/components/scaffold/scaffold.dart';
import 'package:kybele_gen2/main.dart';
import 'package:kybele_gen2/style/style.dart';

import 'dart_forms.dart';
import 'dart_manuals.dart';

class DartHome extends StatelessWidget {
  const DartHome({super.key});

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
                      bkgColor: manualsBkgColor,
                      labelColor: manualsIconColor,
                      iconData: manualsIcon,
                      header: 'Educational Manuals',
                      page: const Framework(child: DartManuals()),
                    ),
                    KTile(
                      bkgColor: formsBkgColor,
                      labelColor: formsIconColor,
                      iconData: formsIcon,
                      header: 'Forms',
                      page: const Framework(child: DartForms()),
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
      headerText: "DART Module",
      bodyWidget: body(context),
    );
  }
}
