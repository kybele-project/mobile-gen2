import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kybele_gen2/components/buttons/buttons.dart'
    show KWideSolidButton;
import 'package:kybele_gen2/components/scaffold/scaffold.dart';
import 'package:kybele_gen2/components/timeline.dart';
import 'package:kybele_gen2/models/event.dart';
import 'package:kybele_gen2/providers/providers.dart';
import 'package:kybele_gen2/style/style.dart';
import 'package:provider/provider.dart';

class OxygenSaturation extends StatefulWidget {
  final bool simVariant;

  const OxygenSaturation({Key? key, required this.simVariant})
      : super(key: key);

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
    int currMinute = (milliseconds / 1000).floor();
    late int currIndex;

    if (currMinute >= 10) {
      currIndex = 5;
    } else if (currMinute >= 5) {
      currIndex = 4;
    } else if (currMinute >= 4) {
      currIndex = 3;
    } else if (currMinute >= 3) {
      currIndex = 2;
    } else if (currMinute >= 2) {
      currIndex = 1;
    } else if (currMinute >= 1) {
      currIndex = 0;
    } else {
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
    } else {
      setState(() {
        _status = 0;
      });
    }

    // TODO: Upgrade function in future
    _status = 2;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.simVariant) {
      return KScaffold.draggableWithHeader(
        startExpanded: false,
        hasHeaderIcon: true,
        headerIconBkgColor: oxygenSatBkgColor,
        headerIconColor: oxygenSatIconColor,
        headerIcon: oxySatIcon,
        hasHeaderClose: true,
        hasBottomActionButton: true,
        bottomButtonText: "Log oxygen saturation",
        bottomButtonMenuWidget: OxygenSaturationMenu(
          header: "Oxygen Saturation",
          subHeader: "$_saturationPercentage%",
          timeInterval: "${_minuteIntervalList[_minuteInterval]} min",
        ),
        headerText: "Oxygen Saturation [SIM]",
        bodyWidget: body(context),
      );
    } else {
      return KScaffold.draggableWithHeader(
        startExpanded: false,
        hasHeaderIcon: true,
        headerIconBkgColor: oxygenSatBkgColor,
        headerIconColor: oxygenSatIconColor,
        headerIcon: oxySatIcon,
        hasHeaderClose: true,
        hasBottomActionButton: false,
        headerText: "Oxygen Saturation",
        bodyWidget: body(context),
      );
    }
  }

  Widget body(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.simVariant
              ? Container(
                  decoration: const BoxDecoration(
                    color: Colors.white54,
                    border: Border(
                      bottom: BorderSide(color: Color(0xffeaeaea), width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  child: Text(
                    "$_saturationPercentage%",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              : Container(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.grey.shade50,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        widget.simVariant
                            ? Row(
                                children: [
                                  const SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _saturationPercentage -= 1;
                                      });
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: mainDarkPurple,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: const Icon(Icons.remove_rounded,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Expanded(
                                    child: Slider(
                                      value: _saturationPercentage.toDouble(),
                                      min: 50,
                                      max: 100,
                                      divisions: 50,
                                      onChanged: (double value) => {
                                        setState(() {
                                          _saturationPercentage = value.toInt();
                                        })
                                      },
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _saturationPercentage += 1;
                                      });
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: mainDarkPurple,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: const Icon(Icons.add_rounded,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                ],
                              )
                            : Container(),
                        widget.simVariant
                            ? const SizedBox(height: 20)
                            : Container(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: OxygenSaturationTable(),
                        ),
                        const SizedBox(
                          height: 300,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * .25,
        decoration: BoxDecoration(
          color: (minuteIndex == currMinuteIndex)
              ? mainDarkPurple
              : Colors.grey.shade500,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            "$label min",
            style: const TextStyle(
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
      border: const TableBorder(
        top: BorderSide(color: Color(0xffeaeaea), width: 1),
        right: BorderSide(color: Color(0xffeaeaea), width: 1),
        left: BorderSide(color: Color(0xffeaeaea), width: 1),
        bottom: BorderSide(color: Color(0xffeaeaea), width: 1),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(150),
        1: FlexColumnWidth(),
      },
      children: [
        TableRow(children: [
          TableCell(
            child: Container(
              decoration: BoxDecoration(
                color: mainLightPurple,
              ),
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const Text(
                "",
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
                color: mainLightPurple,
              ),
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const Text(
                "TARGET OXYGEN SATURATION",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]),
        TableRow(children: [
          TableCell(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const Text("1 min",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
          ),
          TableCell(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const Text("60% - 65%",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
            ),
          ),
        ]),
        TableRow(
          children: [
            TableCell(
              child: Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: const Text("2 min",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ),
            ),
            TableCell(
              child: Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: const Text("65% - 70%",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
              ),
            ),
          ],
        ),
        TableRow(children: [
          TableCell(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const Text("3 min",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
          ),
          TableCell(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const Text("70% - 75%",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
            ),
          ),
        ]),
        TableRow(children: [
          TableCell(
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const Text("4 min",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
          ),
          TableCell(
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const Text("75% - 80%",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
            ),
          ),
        ]),
        TableRow(children: [
          TableCell(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const Text("5 min",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
          ),
          TableCell(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const Text("80% - 85%",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
            ),
          ),
        ]),
        TableRow(children: [
          TableCell(
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const Text("10 min",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
          ),
          TableCell(
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const Text("85% - 95%",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
            ),
          ),
        ]),
      ],
    );
  }
}

class OxygenSaturationMenu extends StatefulWidget {
  final String header;
  final String subHeader;
  final String timeInterval;

  const OxygenSaturationMenu({
    Key? key,
    required this.header,
    required this.subHeader,
    required this.timeInterval,
  }) : super(key: key);

  @override
  State<OxygenSaturationMenu> createState() => _OxygenSaturationMenuState();
}

class _OxygenSaturationMenuState extends State<OxygenSaturationMenu> {
  final List<String> _minuteIntervalList = ['1', '5', '10', '15', '20', '30'];
  int _minuteInterval = 0;

  void updateMinuteInterval(int nextMinuteInterval) {
    setState(() {
      _minuteInterval = nextMinuteInterval;
    });
  }

  @override
  Widget build(BuildContext context) {
    final recordProvider = Provider.of<RecordProvider>(context);

    Event oxygenEvent = Event(
      category: 'OxygenSaturation',
      header: widget.header,
      subHeader: widget.subHeader,
      interval: "${_minuteIntervalList[_minuteInterval]} min",
      status: 2,
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            StandardEntry(
              oxygenSatBkgColor,
              oxygenSatIconColor,
              oxySatIcon,
              widget.header,
              widget.subHeader,
              "${_minuteIntervalList[_minuteInterval]} min",
              2,
              DateFormat.Hm()
                  .format(DateTime.now()), // TODO sync with real time
            ),
            const SizedBox(height: 20),
            Row(
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
            const SizedBox(height: 20),
            Row(
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
                SizedBox(width: MediaQuery.of(context).size.width * .25),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                recordProvider.addEvent(oxygenEvent);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const KWideSolidButton(label: "Log oxygen saturation"),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    border: Border.all(width: 2, color: mainLightPurple)),
                width: MediaQuery.of(context).size.width - 40,
                height: 60,
                child: Center(
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: mainLightPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
