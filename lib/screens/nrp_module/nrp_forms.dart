import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/scaffold/scaffold.dart';
import 'package:kybele_gen2/components/body/body.dart' show KPdfGrid;
import 'package:kybele_gen2/metadata/metadata.dart' show nrpFormsList;
import 'package:kybele_gen2/style/style.dart';

class NRPForms extends StatelessWidget {
  const NRPForms({super.key});

  @override
  Widget build(BuildContext context) {
    return KScaffold.fixedWithHeader(
      hasHeaderClose: true,
      hasHeaderIcon: true,
      hasBottomActionButton: false,
      bodyWidget: KPdfGrid(
        documentList: nrpFormsList,
        icon: formsIcon,
        bkgColor: formsBkgColor,
        iconColor: formsIconColor,
      ),
      headerText: "Forms",
      headerIcon: formsIcon,
      headerIconBkgColor: formsBkgColor,
      headerIconColor: formsIconColor,
    );
  }
}
