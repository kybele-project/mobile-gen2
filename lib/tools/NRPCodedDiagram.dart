import 'package:flutter/material.dart';





class NRPCodedDiagram extends StatefulWidget {

  const NRPCodedDiagram({ super.key });

  State<NRPCodedDiagram> createState() => _NRPCodedDiagramState();
}


class _NRPCodedDiagramState extends State<NRPCodedDiagram> with SingleTickerProviderStateMixin {

  static List<Tab> nrpTabs = <Tab>[
    Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.account_tree_rounded),
          Text('Chart')
        ]
      ),
    ),
    Tab(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.table_chart_rounded),
            Text('Tables')
          ]
      ),
    ),
    Tab(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.medication_rounded),
            Text('Meds')
          ]
      ),
    ),
  ];

  late TabController _tabController;
  late int _activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: nrpTabs.length);
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
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
            children: [
              ABCDTable(),
              SizedBox(height:100),
              APGARTable(),
              SizedBox(height:100),
              EndotrachealIntubation(),
              SizedBox(height:100),
              MRSOPATable(),
              SizedBox(height:100),
              PreductalSPO2Table(),
              SizedBox(height:100),

            ],
          ),
        ),
      ),
    ),
    MedicationTable(),
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
                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
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
                              const Text("NRP Information",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)
                              ),

                          IconButton(
                              color: Colors.black,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.close_rounded, size: 28),
                              onPressed: () => {
                                    Navigator.of(context).pop(),
                                  }),
                        ],
                      ),
                      SizedBox(height: 20),
                      TabBar(
                        indicatorColor: Colors.redAccent,
                        controller: _tabController,
                        labelColor: Colors.redAccent,
                        unselectedLabelColor: Colors.grey[500],
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


class ABCDTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text('ABCD Table');
  }
}

class APGARTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text('APGAR Table');
  }
}

class PreductalSPO2Table extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text('Preductal SpO2 Target');
  }
}


class EndotrachealIntubation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text('Endotracheal Intubation');
  }
}

class MRSOPATable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder(
        top: const BorderSide(color: Color(0xffeaeaea), width: 1),
        right: const BorderSide(color: Color(0xffeaeaea), width: 1),
        left: const BorderSide(color: Color(0xffeaeaea), width: 1),
        bottom: const BorderSide(color: Color(0xffeaeaea), width: 1),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(70),
        1: FlexColumnWidth(),
      },
      children: [
        TableRow(
            children: [
              TableCell(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text(
                    "",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text(
                    "ACTIONS",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ]
        ),
        TableRow(
            children: [
              TableCell(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text("M", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text.rich(
                      TextSpan(
                          style: TextStyle(color: Colors.black), //apply style to all
                          children: [
                            TextSpan(text: 'Adjust ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
                            TextSpan(text: 'Mask ', style: TextStyle(fontSize:14, fontWeight: FontWeight.w800)),
                            TextSpan(text: 'to assure good seal on the face', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300))
                          ]
                      )
                  ),
                ),
              ),
            ]
        ),
        TableRow(
          children: [
            TableCell(
              child: Container(
                color: Colors.grey[50],
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text("R.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
              ),
            ),
            TableCell(
              child: Container(
                color: Colors.grey[50],
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text.rich(
                    TextSpan(
                        style: TextStyle(color: Colors.black), //apply style to all
                        children: [
                          TextSpan(text: 'Reposition ', style: TextStyle(fontSize:14, fontWeight: FontWeight.w800)),
                          TextSpan(text: 'airway by adjusting head to "sniffing" position', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300))
                        ]
                    )
                ),
              ),
            ),
          ],
        ),
        TableRow(
            children: [
              TableCell(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text("S", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text.rich(
                      TextSpan(
                          style: TextStyle(color: Colors.black), //apply style to all
                          children: [
                            TextSpan(text: 'Suction ', style: TextStyle(fontSize:14, fontWeight: FontWeight.w800)),
                            TextSpan(text: 'mouth and nose of secretions, if present', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300))
                          ]
                      )
                  ),
                ),
              ),
            ]
        ),
        TableRow(
            children: [
              TableCell(
                child: Container(
                  color: Colors.grey[50],
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text("O", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.grey[50],
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text.rich(
                      TextSpan(
                          style: TextStyle(color: Colors.black), //apply style to all
                          children: [
                            TextSpan(text: 'Open ', style: TextStyle(fontSize:14, fontWeight: FontWeight.w800)),
                            TextSpan(text: 'mouth slightly and move jaw forward', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300))
                          ]
                      )
                  ),
                ),
              ),
            ]
        ),
        TableRow(
            children: [
              TableCell(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text("P", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                ),
              ),
              TableCell(
                child: Container(

                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                      TextSpan(
                          style: TextStyle(color: Colors.black), //apply style to all
                          children: [
                            TextSpan(text: 'Increase', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
                            TextSpan(text: ' Pressure', style: TextStyle(fontSize:14, fontWeight: FontWeight.w800)),
                            TextSpan(text: ' to achieve chest rise', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300))
                          ]
                      )
                  ),
                ),
              ),
            ]
        ),
        TableRow(
            children: [
              TableCell(
                child: Container(
                  color: Colors.grey[50],
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text("A", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.grey[50],
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text.rich(
                      TextSpan(
                          style: TextStyle(color: Colors.black), //apply style to all
                          children: [
                            TextSpan(text: 'Consider', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
                            TextSpan(text: ' Airway', style: TextStyle(fontSize:14, fontWeight: FontWeight.w800)),
                            TextSpan(text: ' alternative (endotracheal intubation or laryngeal mask airway)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300))
                          ]
                      )
                  ),
                ),
              ),
            ]
        ),
      ],
    );
  }
}

class MedicationTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text('Medication Table');
  }
}
