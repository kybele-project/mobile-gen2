import 'package:flutter/material.dart';
import 'package:kybele_gen2/templates/page/page.dart';
import 'package:provider/provider.dart';

class OxygenSaturation extends StatefulWidget {
  const OxygenSaturation({Key? key}) : super(key: key);

  @override
  State<OxygenSaturation> createState() => _OxygenSaturationState();
}

class _OxygenSaturationState extends State<OxygenSaturation> {

  final List<String> _minuteIntervalList = ['1', '2', '3', '4', '5', '10'];
  final List<int> _minuteMSList = [1000, 2000, 3000, 4000, 5000, 10000];
  final List<int> _lowerBound = [60, 65, 70, 75, 80, 85];
  final List<int> _upperBound = [65, 70, 75, 80, 85, 95];

  int _saturationPercentage = 60;
  int _minuteInterval = 0;
  int _status = 1;

  void updateStatus(int milliseconds) {
    int currMinute = (milliseconds/1000).floor();
    late int currIndex;

    if (currMinute >= 10) {
      currIndex = 5;
    }
    else if (currMinute >= 5) {
      currIndex = 4;
    }
    else if (currMinute >= 4) {
      currIndex = 3;
    }
    else if (currMinute >= 3) {
      currIndex = 2;
    }
    else if (currMinute >= 2) {
      currIndex = 1;
    }
    else if (currMinute >= 1) {
      currIndex = 0;
    }
    else {
      setState(() {
        _status = 2;
      });

      return;
    }

    if (_saturationPercentage >= _lowerBound[currIndex] &&
        _saturationPercentage <= _upperBound[currIndex]) {
      setState(() {
        _status = 1;
      });
    }
    else {
      setState(() {
        _status = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return KybelePage.fixedWithHeader(
      hasHeaderIcon: true,
      headerIconBkgColor: const Color(0xffE2EEF9),
      headerIconColor: const Color(0xff436B8F),
      headerIcon: Icons.bubble_chart_rounded,
      hasHeaderClose: true,
      hasBottomActionButton: true,
      bottomButtonText: "Log event",
      bottomButtonMenuWidget: const Placeholder(),
      headerText: "Oxygen Saturation",
      bodyWidget: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: (_status == 2) ? Colors.white : ((_status == 1) ? Colors.green.shade50 : Colors.red.shade50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _saturationPercentage.toString() + "%",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      (_status == 2) ? Container() :
                      ((_status == 1) ? Text(
                        "SAFE",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ) : Text(
                        "UNSAFE",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ],
                  ),
                  (_status != 2) ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Selected: " + _minuteIntervalList[_minuteInterval] + " min",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        _lowerBound[_minuteInterval].toString() + "% - " + _upperBound[_minuteInterval].toString() + "%",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ) : Container(),
                ],
              ),
            ),
            SizedBox(height: 40),
            Slider(
              value: _saturationPercentage.toDouble(),
              min: 50,
              max: 100,
              divisions: 50,
              onChanged: (double value) => {
                setState((){
                  _saturationPercentage = value.toInt();
                  updateStatus(_minuteMSList[_minuteInterval]);
                })
              },
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OxygenSaturationTable(),
            ),
          ],
        ),
      ),
    );
  }
}

class OxygenSaturationTable extends StatelessWidget {

  const OxygenSaturationTable({super.key});

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
        0: FixedColumnWidth(150),
        1: FlexColumnWidth(),
      },
      children: [
        TableRow(
            children: [
              TableCell(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff9F97E3),
                  ),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text(
                    "ELAPSED TIME",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff9F97E3),
                  ),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text(
                    "TARGET OXYGEN SATURATION",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
    );
  }
}