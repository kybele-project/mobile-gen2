import 'package:fl_chart/fl_chart.dart';
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
          padding: EdgeInsets.fromLTRB(0, 0, 00, 0),
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
                height: MediaQuery.of(context).size.width * .35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(
                      color: Color(0xffeaeaea),
                      width: 1,
                    ))),
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    return Column(children: [
      Text("A: Airway"),
      Text("-Place hand in sniffing position\nSuction mouth, then nose"),
      Text("B: Breathing"),
      Text("If apneic")
    ],);
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
    return
    Container( 
      width: double.infinity,
      child:
    Align(alignment: Alignment.centerLeft, child:
    Column(children: [
      Text("Medications Used During or Following Resuscitation", textAlign: TextAlign.left,),
      Text("Epinephrine 1:10000 (0.1 mg/mL)"),
      Table(
      border: TableBorder(
        top: const BorderSide(color: Color(0xffeaeaea), width: 1),
        right: const BorderSide(color: Color(0xffeaeaea), width: 1),
        left: const BorderSide(color: Color(0xffeaeaea), width: 1),
        bottom: const BorderSide(color: Color(0xffeaeaea), width: 1),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(150),
        1: FixedColumnWidth(50),
        2: FlexColumnWidth(),
      },
      children: [
        TableRow(
            children: [
              TableCell(
                child: Container(
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: Text("Dosage/Route*"),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.grey[200],
                  alignment: Alignment.center,
                  child: Text("Wt (kg)", textAlign: TextAlign.left),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.grey[200],
                  alignment: Alignment.center,
                  child: Text("Total Volume (mL)", textAlign: TextAlign.left),
                ),
              ),
            ]
        ),
        TableRow(
            children: [
              TableCell(
                child: Container(
                  color: Colors.grey[50],
                  alignment: Alignment.center,
                  child: Text("0.1 to 0.4 mL/kg\nInterveneous (preferred route)"),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.grey[50],
                  alignment: Alignment.center,
                  child: Text("1\n2\n3\n4"),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.grey[50],
                  alignment: Alignment.center,
                  child: Text("0.1-0.3\n0.2-0.6\n0.3-0.9\n0.4-1.2"),
                ),
              ),
            ]
        ),
        
      ],
    )
    ]))
    );
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
    return 
    Expanded(child:
    SingleChildScrollView(child:
    InteractiveViewer(child:
    Container(
      padding: const EdgeInsets.all(10),
      child:
    Column(children: [
      Container(
        width: double.infinity,
        child: Text("Epinephrine", textAlign: TextAlign.left, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700))),
      Container(
        width: double.infinity,
        child: Text("1:10000 (0.1 mg/mL)", textAlign: TextAlign.left, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400))),
      SizedBox(height: 10),
      Table(
      border: TableBorder(
        top: const BorderSide(color: Color(0xffeaeaea), width: 1),
        right: const BorderSide(color: Color(0xffeaeaea), width: 1),
        left: const BorderSide(color: Color(0xffeaeaea), width: 1),
        bottom: const BorderSide(color: Color(0xffeaeaea), width: 1),
        horizontalInside: const BorderSide(color: Colors.black),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(170),
        1: FixedColumnWidth(50),
        2: FlexColumnWidth(),
      },
      children: [
        TableRow(
            children: [
              TableCell(
                child: Container(
                  color: Color(0xff7266d7),
                  alignment: Alignment.center,
                  child: Text("Dosage/Route*", textAlign: TextAlign.left, style:(TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                ),
              ),
              TableCell(
                child: Container(
                  color: Color(0xff7266d7),
                  alignment: Alignment.center,
                  child: Text("Wt (kg)", textAlign: TextAlign.left, style:(TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                ),
              ),
              TableCell(
                child: Container(
                  color: Color(0xff7266d7),
                  alignment: Alignment.center,
                  child: Text("Total Volume (mL)", textAlign: TextAlign.left, style:(TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                ),
              ),
            ]
        ),
        TableRow(
            children: [
              TableCell(
                child: Container(
                  color: Colors.grey[50],
                  alignment: Alignment.center,
                  child: Text("0.1 to 0.4 mL/kg\nInterveneous (preferred route)"),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.grey[50],
                  alignment: Alignment.center,
                  child: Text("1\n2\n3\n4"),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.grey[50],
                  alignment: Alignment.center,
                  child: Text("0.1 - 0.3\n0.2 - 0.6\n0.3 - 0.9\n0.4 - 1.2"),
                ),
              ),
            ]
        ),
        TableRow(
            children: [
              TableCell(
                child: Container(
                  color: Colors.grey[50],
                  alignment: Alignment.center,
                  child: Text("0.5 to 1 mL/kg\nEndotracheal (acceptable until IV established)"),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.grey[50],
                  alignment: Alignment.center,
                  child: Text("1\n2\n3\n4"),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.grey[50],
                  alignment: Alignment.center,
                  child: Text("0.5 - 1.0\n1.0 - 2.0\n1.5 - 3.0\n2.0 - 4.0"),
                ),
              ),
            ]
        ),
        
        
      ],
    ),
    Text("*Give rapidly; follow IV dose with 0.5 - 1 mL of normal saline flush\n*Repeat every 3-5 minutes if HR < 60 with chest compressions\nAfter ET dose, may give IV epinephrine as soon as IV route is established", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),
      SizedBox(height: 40),
      Container(
        width: double.infinity,
        child: Text("Volume Expanders", textAlign: TextAlign.left, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700))),
      Container(
        width: double.infinity,
        child: Text("(Normal Saline,O-negative PRBC)", textAlign: TextAlign.left, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400))),
      SizedBox(height: 10),
      Table(
      border: TableBorder(
        top: const BorderSide(color: Color(0xffeaeaea), width: 1),
        right: const BorderSide(color: Color(0xffeaeaea), width: 1),
        left: const BorderSide(color: Color(0xffeaeaea), width: 1),
        bottom: const BorderSide(color: Color(0xffeaeaea), width: 1),
        horizontalInside: const BorderSide(color: Colors.black),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(170),
        1: FixedColumnWidth(50),
        2: FlexColumnWidth(),
      },
      children: [
        TableRow(
            children: [
              TableCell(
                child: Container(
                  color: Color(0xff7266d7),
                  alignment: Alignment.center,
                  child: Text("Dosage/Route*", textAlign: TextAlign.left, style:(TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                ),
              ),
              TableCell(
                child: Container(
                  color: Color(0xff7266d7),
                  alignment: Alignment.center,
                  child: Text("Wt (kg)", textAlign: TextAlign.left, style:(TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                ),
              ),
              TableCell(
                child: Container(
                  color: Color(0xff7266d7),
                  alignment: Alignment.center,
                  child: Text("Total Volume (mL)", textAlign: TextAlign.left, style:(TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                ),
              ),
            ]
        ),
        TableRow(
            children: [
              TableCell(
                child: Container(
                  color: Colors.grey[50],
                  alignment: Alignment.topLeft,
                  child: Text("10 mL/kg IV"),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.grey[50],
                  alignment: Alignment.center,
                  child: Text("1\n2\n3\n4"),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.grey[50],
                  alignment: Alignment.center,
                  child: Text("10\n20\n20\n40"),
                ),
              ),
            ]
        ),
        
        
      ],
    ),
    Container(color: Colors.grey[100], child:
    Text("*Not responding to steps of resuscitation and has signs of shock or history of acute blood loss.\n*Give over 5-10 minutes", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),
    )]
    )))));
  }
}
