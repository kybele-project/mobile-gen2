import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kybele_gen2/models/event.dart';
import 'package:kybele_gen2/templates/page/page.dart';
import 'package:provider/provider.dart';

import '../components/button.dart';
import '../components/timeline.dart';
import '../providers/kybele_providers.dart';


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
  int _status = 2;

  void updateMinuteInterval(int nextMinuteInterval) {
    setState(() {
      _minuteInterval = nextMinuteInterval;
    });
    updateStatus(_minuteMSList[_minuteInterval]);
  }

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

    // TODO: Upgrade function in future
    _status = 2;
  }

  @override
  Widget build(BuildContext context) {
    return KybelePage.draggableWithHeader(
      startExpanded: false,
      hasHeaderIcon: true,
      headerIconBkgColor: const Color(0xffE2EEF9),
      headerIconColor: const Color(0xff436B8F),
      headerIcon: Icons.bubble_chart_rounded,
      hasHeaderClose: true,
      hasBottomActionButton: true,
      bottomButtonText: "Log oxygen saturation",
      bottomButtonMenuWidget: OxygenSaturationMenu(
        header: "Oxygen Saturation",
        subHeader: "$_saturationPercentage%",
        timeInterval: "${_minuteIntervalList[_minuteInterval]} min",
      ),
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
                        "$_saturationPercentage%",
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      (_status == 2) ? Container() :
                      ((_status == 1) ? const Text(
                        "SAFE",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ) : const Text(
                        "UNSAFE",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ],
                  ),
                  (_status == 2) ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Selected: ${_minuteIntervalList[_minuteInterval]} min",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        "${_lowerBound[_minuteInterval]}% - ${_upperBound[_minuteInterval]}%",
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
            Container(
              color: Colors.grey.shade100,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _saturationPercentage -= 1;
                            updateStatus(_minuteMSList[_minuteInterval]);
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Color(0xff564BAF),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Icon(Icons.remove_rounded, color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Slider(
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
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _saturationPercentage += 1;
                            updateStatus(_minuteMSList[_minuteInterval]);
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Color(0xff564BAF),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Icon(Icons.add_rounded, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OxygenSaturationButton(
                          label: _minuteIntervalList[0],
                          minuteIndex: 0,
                          currMinuteIndex: _minuteInterval,
                          updateFunction: updateMinuteInterval,
                        ),
                        OxygenSaturationButton(
                          label: _minuteIntervalList[1],
                          minuteIndex: 1,
                          currMinuteIndex: _minuteInterval,
                          updateFunction: updateMinuteInterval,
                        ),
                        OxygenSaturationButton(
                          label: _minuteIntervalList[2],
                          minuteIndex: 2,
                          currMinuteIndex: _minuteInterval,
                          updateFunction: updateMinuteInterval,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OxygenSaturationButton(
                          label: _minuteIntervalList[3],
                          minuteIndex: 3,
                          currMinuteIndex: _minuteInterval,
                          updateFunction: updateMinuteInterval,
                        ),
                        OxygenSaturationButton(
                          label: _minuteIntervalList[4],
                          minuteIndex: 4,
                          currMinuteIndex: _minuteInterval,
                          updateFunction: updateMinuteInterval,
                        ),
                        OxygenSaturationButton(
                          label: _minuteIntervalList[5],
                          minuteIndex: 5,
                          currMinuteIndex: _minuteInterval,
                          updateFunction: updateMinuteInterval,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: OxygenSaturationTable(),
                  ),
                  SizedBox(height: 80,)
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class OxygenSaturationButton extends StatelessWidget {

  final String label;
  final int minuteIndex;
  final int currMinuteIndex;
  final void Function(int) updateFunction;

  const OxygenSaturationButton({
    required this.label,
    required this.minuteIndex,
    required this.currMinuteIndex,
    required this.updateFunction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => updateFunction(minuteIndex),
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * .25,
          decoration: BoxDecoration(
            color: (minuteIndex == currMinuteIndex) ? Color(0xff564BAF) : Colors.grey.shade600,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(label + " min",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
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
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text("1 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
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
                color: Colors.grey[200],
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text("2 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ),
            ),
            TableCell(
              child: Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(10),
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
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text("3 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
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
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text("4 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(10),
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
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text("5 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
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
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text("10 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                ),
              ),
              TableCell(
                child: Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(10),
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

class OxygenSaturationMenu extends StatefulWidget {

  final String header;
  final String subHeader;
  final String timeInterval;

  const OxygenSaturationMenu({Key? key,
    required this.header,
    required this.subHeader,
    required this.timeInterval,
  }) : super(key: key);

  @override
  State<OxygenSaturationMenu> createState() => _OxygenSaturationMenuState();
}

class _OxygenSaturationMenuState extends State<OxygenSaturationMenu> {

  @override
  Widget build(BuildContext context) {
    final recordProvider = Provider.of<RecordProvider>(context);

    Event oxygenEvent = Event(
      category: 'OxygenSaturation',
      header: widget.header,
      subHeader: widget.subHeader,
      interval: widget.timeInterval,
      status: 2,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          StandardEntry(
            const Color(0xffE2EEF9),
            const Color(0xff436B8F),
            Icons.bubble_chart_rounded,
            widget.header,
            widget.subHeader,
            widget.timeInterval,
            2,
            DateFormat.Hm().format(DateTime.now()), // TODO sync with real time
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              recordProvider.addEvent(oxygenEvent);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: KybeleSolidButton("Log oxygen saturation"),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 2, color: const Color(0xff9F97E3))
              ),
              width: MediaQuery.of(context).size.width - 40,
              height: 60,
              child: const Center(
                child:
                Text(
                  'Back',
                  style: TextStyle(
                    color: Color(0xff9F97E3),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}