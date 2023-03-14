import 'package:flutter/material.dart';
import '../style/style.dart';
import '../templates/page/page.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme menuText = GoogleFonts.ptSansTextTheme();

class NRPCodedDiagram extends StatefulWidget {
  const NRPCodedDiagram({super.key});

  @override
  State<NRPCodedDiagram> createState() => _NRPCodedDiagramState();
}

class _NRPCodedDiagramState extends State<NRPCodedDiagram>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InteractiveViewer(
        minScale: 0.1,
        maxScale: 2.8,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/Tables.png'),
            ),
          ),
        ),
      ),
    );
  }
}

class TablesPages extends StatelessWidget {
  const TablesPages({super.key});

  @override
  Widget build(BuildContext context) {
    return KybelePage.fixedWithHeader(
      hasHeaderClose: true,
      hasHeaderIcon: true,
      hasBottomActionButton: false,
      bodyWidget: const NRPCodedDiagram(),
      headerText: "Tables",
      headerIcon: tablesIcon,
      headerIconBkgColor: tablesBkgColor,
      headerIconColor: tablesIconColor,
    );
  }
}
