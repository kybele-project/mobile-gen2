import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/scaffold/scaffold.dart';
import 'package:kybele_gen2/style/style.dart';

class NRPTable extends StatefulWidget {
  const NRPTable({super.key});

  @override
  State<NRPTable> createState() => _NRPTableDiagramState();
}

class _NRPTableDiagramState extends State<NRPTable>
    with SingleTickerProviderStateMixin {
  static const List<Tab> nrpTabs = <Tab>[
    Tab(text: 'Ventilation'),
    Tab(text: 'Target Oxygen'),
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
              image: AssetImage('assets/Tables.png'),
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
              image: AssetImage('assets/Target_O2.png'),
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

class TablesPages extends StatelessWidget {
  const TablesPages({super.key});

  @override
  Widget build(BuildContext context) {
    return KScaffold.fixedWithHeader(
      hasHeaderClose: true,
      hasHeaderIcon: true,
      hasBottomActionButton: false,
      bodyWidget: const NRPTable(),
      headerText: "Tables",
      headerIcon: tablesIcon,
      headerIconBkgColor: tablesBkgColor,
      headerIconColor: tablesIconColor,
    );
  }
}
