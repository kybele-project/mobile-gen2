import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/timeline.dart';
import 'package:kybele_gen2/screens/APGAR3.dart';
import 'package:kybele_gen2/screens/TargetOxygenSaturation2.dart';

import '../components/button.dart';
import '../templates/page/page.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme menuText = GoogleFonts.ptSansTextTheme();

class NRPCodedDiagram extends StatefulWidget {

  const NRPCodedDiagram({ super.key });

  State<NRPCodedDiagram> createState() => _NRPCodedDiagramState();
}


class _NRPCodedDiagramState extends State<NRPCodedDiagram> with SingleTickerProviderStateMixin {

  static const List<Tab> nrpTabs = <Tab>[
    Tab(text: 'Flow Chart'),
    Tab(text: 'Tables'),
  ];

  late TabController _tabController;
  late int _activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: nrpTabs.length);
    _tabController.addListener(_setActiveTabIndex);
  }

  void _setActiveTabIndex() {
    _activeTabIndex = _tabController.index;
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Widget> tabBodies = [
    Expanded(
      child: InteractiveViewer(
        minScale: 0.1,
        maxScale: 2.8,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/NRP FlowChart.png'),
            ),
          ),
        ),
      ),
    ),
    Expanded(
      child: InteractiveViewer(
        minScale: 0.1,
        maxScale: 2.8,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/Tables.png'),
            ),
          ),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _activeTabIndex = _tabController.index;
        });
      }
    });

    return 
        Expanded(child:Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 00, 0),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(
                      color: Color(0xffeaeaea),
                      width: 1,
                    ))),
                child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        unselectedLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey[600],
                        tabs: nrpTabs,
                      ),
                    ],
                  ),
              ),
              tabBodies[_activeTabIndex],
            ],
          ));
  }
}


class NRPPages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return KybelePage.fixedWithHeader(
      hasHeaderClose: true,
      hasHeaderIcon: true,
      hasBottomActionButton: false,
      bodyWidget: NRPCodedDiagram(),
      headerText: "Algorithm",
      headerIcon: Icons.account_tree_rounded,
      headerIconBkgColor: const Color(0xffffe9cc),
      headerIconColor: const Color(0xff89683e),
    );
  }
}
