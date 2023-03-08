import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/timeline.dart';
import 'package:kybele_gen2/screens/apgar.dart';

import '../components/button.dart';
import '../main.dart';
import '../templates/page/page.dart';
import 'oxygen_saturation.dart';

class RecordPages extends StatelessWidget {

  const RecordPages({super.key});

  Widget body() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Timeline(),
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
          const KybeleColorfulButton(Color(0xffFFCDCF), Color(0xff8B3E42), Icons.calculate_rounded, 'APGAR Score', Framework(child: APGARCalculator2(simVariant: true))),
          const SizedBox(height: 20),
          const KybeleColorfulButton(Color(0xffE2EEF9), Color(0xff436B8F), Icons.bubble_chart_rounded, 'Oxygen Saturation', Framework(child: OxygenSaturation(simVariant: true))),
          const SizedBox(height: 20),
          GestureDetector(onTap: () => {Navigator.pop(context)}, child: const KybeleOutlineButton('Cancel')),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KybelePage.draggableWithHeader(
      startExpanded: true,
      hasHeaderIcon: true,
      hasHeaderClose: true,
      hasBottomActionButton: true,
      bodyWidget: body(),
      headerText: "Record",
      headerIcon: Icons.list_alt_rounded,
      headerIconBkgColor: const Color(0xffdddddd),
      headerIconColor: const Color(0xff555555),
      bottomButtonText: "Log event",
      bottomButtonMenuWidget: buttonMenu(context),
    );
  }
}