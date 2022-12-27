import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kybele_gen2/nav/header.dart';

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
              image: AssetImage('assets/NRPFlowChart.jpg'),
            ),
          ),
        ),
      ),
    ),
    Expanded(
      child: Center(child: Text('Hello')),
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

    return Material(
      child: SafeArea(
        child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(
                      color: Color(0xffeaeaea),
                      width: 1,
                    ))),
                child: Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.account_tree_rounded,
                                  color: Colors.redAccent, size: 30),
                              const SizedBox(width: 20),
                              const Text("NRP Flow Chart",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          IconButton(
                              color: Colors.black,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () => {
                                    Navigator.of(context).pop(),
                                  }),
                        ],
                      ),
                      SizedBox(height: 10),
                      TabBar(
                        controller: _tabController,
                        labelColor: Colors.grey[500],
                        tabs: nrpTabs,
                      ),
                    ],
                  ),
                ),
              ),
              tabBodies[_activeTabIndex],
            ],
          ),
        ),
    );
  }
}
