import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/scaffold/scaffold.dart';
import 'package:kybele_gen2/style/style.dart';

class NRPCodedDiagram extends StatefulWidget {
  const NRPCodedDiagram({super.key});

  @override
  State<NRPCodedDiagram> createState() => _NRPCodedDiagramState();
}

class _NRPCodedDiagramState extends State<NRPCodedDiagram>
    with SingleTickerProviderStateMixin {
  static const List<Tab> nrpTabs = <Tab>[
    Tab(text: 'Flow Chart'),
    Tab(text: 'ABCs'),
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
          decoration: const BoxDecoration(
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/ABCs.png'),
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

    return Expanded(
        child: Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 00, 0),
          width: double.maxFinite,
          decoration: const BoxDecoration(
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
                labelStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                unselectedLabelStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
  const NRPPages({super.key});

  @override
  Widget build(BuildContext context) {
    return KScaffold.fixedWithHeader(
      hasHeaderClose: true,
      hasHeaderIcon: true,
      hasBottomActionButton: false,
      bodyWidget: const NRPCodedDiagram(),
      headerText: "Algorithm",
      headerIcon: algorithmIcon,
      headerIconBkgColor: algorithmBkgColor,
      headerIconColor: algorithmIconColor,
    );
  }
}
