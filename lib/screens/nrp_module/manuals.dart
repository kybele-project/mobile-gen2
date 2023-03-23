import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/scaffold/scaffold.dart';
import 'package:kybele_gen2/components/body/body.dart' show KPdfGrid;
import 'package:kybele_gen2/metadata/metadata.dart' show manualsList;
import 'package:kybele_gen2/style/style.dart';

class Manuals extends StatelessWidget {
  const Manuals({super.key});

  @override
  Widget build(BuildContext context) {
    return KScaffold.fixedWithHeader(
      hasHeaderClose: true,
      hasHeaderIcon: true,
      hasBottomActionButton: false,
      bodyWidget: KPdfGrid(
        documentList: manualsList,
        icon: manualsIcon,
        bkgColor: manualsBkgColor,
        iconColor: manualsIconColor,
      ),
      headerText: "Educational Manuals",
      headerIcon: manualsIcon,
      headerIconBkgColor: manualsBkgColor,
      headerIconColor: manualsIconColor,
    );
  }
}
