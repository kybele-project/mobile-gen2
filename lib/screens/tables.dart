import 'package:flutter/material.dart';
import '../templates/page/page.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme menuText = GoogleFonts.ptSansTextTheme();

class NRPCodedDiagram extends StatefulWidget {

  const NRPCodedDiagram({ super.key });

  @override
  State<NRPCodedDiagram> createState() => _NRPCodedDiagramState();
}


class _NRPCodedDiagramState extends State<NRPCodedDiagram> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {

    return 
        Expanded(
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
    return const KybelePage.fixedWithHeader(
      hasHeaderClose: true,
      hasHeaderIcon: true,
      hasBottomActionButton: false,
      bodyWidget: NRPCodedDiagram(),
      headerText: "Tables",
      headerIcon: Icons.dataset_rounded,
      headerIconBkgColor: Color(0xffe1f9f8),
      headerIconColor: Color(0xff438e89),
    );
  }
}
