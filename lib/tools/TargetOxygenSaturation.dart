import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kybele_gen2/nav/header.dart';
import 'package:kybele_gen2/log/recordProvider.dart';
import 'package:provider/provider.dart';


class TargetOxygenSaturation extends StatelessWidget {
  const TargetOxygenSaturation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Material(
      child: SafeArea(
        child: Column(
          children: [
            PopUpHeader(
              'Target Oxygen Saturation',
              Icon(
                Icons.bubble_chart_rounded,
                color: Colors.lightBlueAccent,
                size: 30,
              ),
            ),
            Expanded(
                  child: SingleChildScrollView(
              child: Column (
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
                    child: Column(children: [
                      LineChartSample1(),
                      Container(
                        child: Table(
                          border: TableBorder(
                            top: const BorderSide(color: Color(0xffeaeaea), width: 1),
                            right: const BorderSide(color: Color(0xffeaeaea), width: 1),
                            left: const BorderSide(color: Color(0xffeaeaea), width: 1),
                            bottom: const BorderSide(color: Color(0xffeaeaea), width: 1),
                          ),
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(150),
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
                                        "ELAPSED TIME",
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
                                        "TARGET OXYGEN SATURATION",
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
                                      child: Text("1 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.all(8),
                                      alignment: Alignment.center,
                                      child: Text("60% - 65%", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
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
                                    child: Text("2 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    color: Colors.grey[50],
                                    padding: EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    child: Text("65% - 70%", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
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
                                      child: Text("3 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.all(8),
                                      alignment: Alignment.center,
                                      child: Text("70% - 75%", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
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
                                      child: Text("4 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      color: Colors.grey[50],
                                      padding: EdgeInsets.all(8),
                                      alignment: Alignment.center,
                                      child: Text("75% - 80%", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
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
                                      child: Text("5 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.all(8),
                                      alignment: Alignment.center,
                                      child: Text("80% - 85%", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
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
                                      child: Text("10 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      color: Colors.grey[50],
                                      padding: EdgeInsets.all(8),
                                      alignment: Alignment.center,
                                      child: Text("85% - 95%", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
                                    ),
                                  ),
                                ]
                            ),
                          ],
                        ),
                      ),

                    ]),
                  ),
                Container(
                  padding: EdgeInsets.all(30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(width: 1, color: Color(0xffeaeaea))
                    ),
                  ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OxygenRecord(),
                  ],
                ),
              ),
              ],
            ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}


class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
    );
  }

  LineChartData get sampleData1 => LineChartData(
    lineTouchData: lineTouchData1,
    gridData: gridData,
    titlesData: titlesData1,
    borderData: borderData,
    lineBarsData: lineBarsData1,
    minX: 0,
    maxX: 11,
    maxY: 95,
    minY: 55,
    betweenBarsData: [
      BetweenBarsData(
        fromIndex: 0,
        toIndex: 1,
        color: Colors.blue.withOpacity(0.3),
      )
    ],
  );

  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.white.withOpacity(0.8),
    ),
  );

  FlTitlesData get titlesData1 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      axisNameWidget: const Text(
        'TARGET OXYGEN SATURATION',
        style: TextStyle(
          color: Colors.black,
          fontSize: 10,
        ),
      ),
      sideTitles: leftTitles(),
    ),
  );

  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarData1_1,
    lineChartBarData1_2,
  ];

  LineTouchData get lineTouchData2 => LineTouchData(
    enabled: false,
  );

  FlTitlesData get titlesData2 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ),
  );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 50:
        text = '50%';
        break;
      case 60:
        text = '60%';
        break;
      case 70:
        text = '70%';
        break;
      case 80:
        text = '80%';
        break;
      case 90:
        text = '90%';
        break;
      case 100:
        text = '100%';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    interval: 1,
    reservedSize: 40,
  );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('0 min', style: style);
        break;
      case 5:
        text = const Text('5 min', style: style);
        break;
      case 10:
        text = const Text('10 min', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: const Border(
      bottom: BorderSide(color: Colors.black38, width: 1),
      left: BorderSide(color: Colors.black38, width: 1),
      right: BorderSide(color: Colors.transparent),
      top: BorderSide(color: Colors.transparent),
    ),
  );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
    isCurved: false,
    color: Colors.blue,
    barWidth: 2,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: const [
      FlSpot(1, 60),
      FlSpot(2, 65),
      FlSpot(3, 70),
      FlSpot(4, 75),
      FlSpot(5, 80),
      FlSpot(10, 85),
    ],
  );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
    isCurved: false,
    color: Colors.blue,
    barWidth: 2,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(
      show: false,
      color: const Color(0x00aa4cfc),
    ),
    spots: const [
      FlSpot(1, 65),
      FlSpot(2, 70),
      FlSpot(3, 75),
      FlSpot(4, 80),
      FlSpot(5, 85),
      FlSpot(10, 95),
    ],
  );
}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 6),
                    child: _LineChart(isShowingMainData: isShowingMainData),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}


class OxygenRecord extends StatefulWidget {

  @override
  State<OxygenRecord> createState() => _OxygenRecordState();

}


class _OxygenRecordState extends State<OxygenRecord> {

  double _currentSliderValue = 50;

  @override
  Widget build(BuildContext context) {

    final recordProvider = Provider.of<RecordProvider>(context);

    void saveData(Event event) {
      recordProvider.addEvent(event);
    }

    return Column(
      children: [
        Text("Current Oxygen Saturation: " + _currentSliderValue.round().toString() + "%", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Slider(
          value: _currentSliderValue,
          min: 50,
          max: 100,
          divisions: 10,
          label: _currentSliderValue.round().toString() + "%",
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
        SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
            ),
            onPressed:() {
              Event o2Event = Event(
                category: 'OxygenSaturation',
                header: 'Oxygen Saturation: ${_currentSliderValue.toInt()}%',
                subHeader: 'Insert status here',
                interval: 'Test'
              );
              saveData(o2Event);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Oxygen Saturation Record Added!'),
                  action: SnackBarAction(label: "Undo", onPressed: () {},)
                )
              );
            },
            child: Text("Add to record",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16))
          ),
        ),
      ],
    );
  }
}