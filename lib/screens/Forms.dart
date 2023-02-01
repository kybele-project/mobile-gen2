import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/timeline.dart';
import 'package:kybele_gen2/screens/APGAR3.dart';
import 'package:kybele_gen2/screens/TargetOxygenSaturation2.dart';
import 'package:kybele_gen2/old/tools/AdditionalResources.dart';

import '../components/button.dart';
import '../templates/page/page.dart';

class FormsPages extends StatelessWidget {

  Widget body() {
    return Expanded(
      child: ListView(
                children: [
                  KybelePDFTile(
                    "NRP Checklist",
                    RenderScreen(
                      "NRP Checklist",
                      "assets/NRPQuickEquipmentChecklist.pdf",
                    ),
                  ),
                  KybelePDFTile(
                    "A4 NRP Checklist",
                    RenderScreen(
                      "A4 NRP Checklist",
                      "assets/A4 - NRP Checklist 27Oct2022.pdf",
                    ),
                  ),
                  KybelePDFTile(
                    "T-Piece Resuscitator for Lamination",
                    RenderScreen(
                      "T-Piece Resuscitator for Lamination",
                      "assets/T-Piece resuscitator for lamination.pdf",
                    ),
                  ),
                  KybelePDFTile(
                    "Warmilu Thermal Gel Instructions",
                    RenderScreen(
                      "A4 NRP Checklist",
                      "assets/Warmilu_thermal gel autoclave instructions.pdf",
                    ),
                  ),

                ]
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KybelePage.fixedWithHeader(
      hasHeaderClose: true,
      hasHeaderIcon: true,
      hasBottomActionButton: false,
      bodyWidget: body(),
      headerText: "Forms",
      headerIcon: Icons.list_alt_rounded,
      headerIconBkgColor: const Color.fromARGB(255, 221, 221, 221),
      headerIconColor: const Color.fromARGB(255, 253, 100, 100),
    );
  }
}