import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/scaffold/scaffold.dart';
import 'package:kybele_gen2/components/body/body.dart' show KPdfGrid;
import 'package:kybele_gen2/metadata/metadata.dart' show nrpManualsList;
import 'package:kybele_gen2/style/style.dart';

class NRPManuals extends StatelessWidget {
  const NRPManuals({super.key});

  @override
  Widget build(BuildContext context) {
    return KScaffold.fixedWithHeader(
      hasHeaderClose: true,
      hasHeaderIcon: true,
      hasBottomActionButton: false,
      bodyWidget: KPdfGrid(
        documentList: nrpManualsList,
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
