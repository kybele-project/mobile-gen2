import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kybele_gen2/providers/kybele_providers.dart';

import 'package:provider/provider.dart';

import '../components/button.dart';
import '../components/timeline.dart';
import '../databases/record_database.dart';
import '../models/event.dart';
import '../components/customtoggleswitch.dart';
import '../templates/page/page.dart';
import 'oxygen_saturation.dart';


class APGARCalculator2 extends StatefulWidget {
  final bool simVariant;

  const APGARCalculator2({required this.simVariant, super.key});

  @override
  State<APGARCalculator2> createState() => _APGARCalculatorState2();
}

class _APGARCalculatorState2 extends State<APGARCalculator2> {
  RecordDatabase db = RecordDatabase();

  int _scoreAPGAR = 10;
  int _varA1 = 2;
  int _varP = 2;
  int _varG = 2;
  int _varA2 = 2;
  int _varR = 2;

  String _dropdownValue = "Event";

  final List<String> intervals = [
    "Event",
    "1 min",
    "5 min",
    "10 min",
  ];

  final List<Color> colors_list = [
    Colors.redAccent,
    Colors.amber,
    Colors.green,
  ];

  final List<Color> colors_list2 = [
    Color.fromARGB(255, 184, 89, 89),
    Color.fromARGB(255, 227, 208, 122),
    Color.fromARGB(255, 110, 205, 101),
  ];

  @override
  Widget build(BuildContext context) {

    if (widget.simVariant) {
      return KybelePage.draggableWithHeader(
        startExpanded: false,
        hasBottomActionButton: true,
        hasHeaderIcon: true,
        hasHeaderClose: true,
        bodyWidget: body(context),
        headerText: "APGAR Score [SIM]",
        headerIcon: Icons.calculate_rounded,
        headerIconBkgColor: const Color(0xffFFCDCF),
        headerIconColor: const Color(0xff8B3E42),
        bottomButtonText: "Log APGAR score",
        bottomButtonMenuWidget: APGARMenu(
          header: 'APGAR Score: $_scoreAPGAR',
          subHeader: 'A: $_varA1, P: $_varP, G: $_varG, A: $_varA2, R: $_varR',
          timeInterval: "1 min",
          A: _varA1,
          P: _varP,
          G: _varG,
          A2: _varA2,
          R: _varR,
        ),
      );
    }
    else {
      return KybelePage.draggableWithHeader(
        startExpanded: false,
        hasBottomActionButton: false,
        hasHeaderIcon: true,
        hasHeaderClose: true,
        bodyWidget: body(context),
        headerText: "APGAR Score",
        headerIcon: Icons.calculate_rounded,
        headerIconBkgColor: const Color(0xffFFCDCF),
        headerIconColor: const Color(0xff8B3E42),
      );
    }
  }

  Widget buttonMenu(context) {
    final recordProvider = Provider.of<RecordProvider>(context);

    Event apgarEvent = Event(
      category: 'APGAR',
      header: 'APGAR Score: $_scoreAPGAR',
      subHeader: 'A: $_varA1, P: $_varP, G: $_varG, A: $_varA2, R: $_varR',
      interval: _dropdownValue,
      status: 0,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          StandardEntry(
            const Color(0xffFFCDCF),
            const Color(0xff8B3E42),
            Icons.calculate_rounded,
            'APGAR Score: $_scoreAPGAR',
            'A: $_varA1, P: $_varP, G: $_varG, A: $_varA2, R: $_varR',
            _dropdownValue,
            0,
            DateFormat.Hm().format(DateTime.now()), // TODO sync with real time
          ),
          const SizedBox(height: 20),
          DropdownButton<String>(
            value: _dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                _dropdownValue = value!;
              });
            },
            items: intervals.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
            }).toList(),
    ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              recordProvider.addEvent(apgarEvent);
              Navigator.pop(context);
            },
            child: KybeleSolidButton("Log APGAR score"),
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

  Widget body(context) {
    return Expanded(
      child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white54,
              border: Border(
                  bottom: BorderSide(
                      color: Color(0xffeaeaea), width: 1))),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: (_scoreAPGAR >= 8)
                          ? Text("$_scoreAPGAR",
                          style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                              color: Colors.green))
                          : ((_scoreAPGAR >= 6)
                          ? Text("$_scoreAPGAR",
                          style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                              color: Colors.amber))
                          : Text("$_scoreAPGAR",
                          style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                              color: Colors.redAccent))),
                    ),
                    /* APGAR Score Indicator
                    Flexible(
                      child: (_scoreAPGAR >= 8)
                          ? Text("Normal",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center)
                          : ((_scoreAPGAR >= 6)
                          ? Text("Further monitoring\nrequired",
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right)
                          : Text(
                          "Immediate medical\nattention needed",
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right)),
                    ), */
                  ],
                ),
              ],
            ),
          ),
        ),
      Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor

            
            Container(
              color: Colors.grey[50],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 85),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Appearance",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Image.asset('assets/apgar_blue.png', height: 100),
                    const SizedBox(height: 10),
                    Container(
                      width: double.maxFinite,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xccbbbbbb),
                              offset: Offset(0, 3),
                              blurRadius: 5),
                        ],
                      ),
                      child: LayoutBuilder(builder:
                          (BuildContext context,
                          BoxConstraints constraints) {
                        double toggleWidth =
                            (constraints.maxWidth - 2) / 3;
                        return ToggleSwitch(
                          dividerColor: Colors.grey,
                          customWidths: [
                            toggleWidth,
                            toggleWidth,
                            toggleWidth
                          ],
                          cornerRadius: 10,
                          initialLabelIndex: _varA1,
                          totalSwitches: 3,
                          inactiveFgColor: Color(0xccbbbbbb),
                          labels: [
                            'Blue all over',
                            'Blue only at\nextremities',
                            'No blue\ncoloration'
                          ],
                          customTextStyles: [
                            TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ],
                          activeBgColors: [
                            [Color.fromARGB(255, 184, 89, 89)],
                            [Color.fromARGB(255, 227, 208, 122)],
                            [Color.fromARGB(255, 110, 205, 101)],
                          ],
                          inactiveBgColor: Color(0xffffffff),
                          onToggle: (index) {
                            setState(() {
                              _varA1 = index!;
                              _scoreAPGAR = _varA1 +
                                  _varP +
                                  _varG +
                                  _varA2 +
                                  _varR;
                            });
                          },
                          radiusStyle: true,
                        );
                      }),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Pulse",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Image.asset('assets/apgar_pulse.png', height: 100),
                    const SizedBox(height: 10),
                    Container(
                      width: double.maxFinite,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xccbbbbbb),
                              offset: Offset(0, 3),
                              blurRadius: 5),
                        ],
                      ),
                      child: LayoutBuilder(builder:
                          (BuildContext context,
                          BoxConstraints constraints) {
                        double toggleWidth =
                            (constraints.maxWidth - 2) / 3;
                        return ToggleSwitch(
                          dividerColor: Colors.grey,
                          customWidths: [
                            toggleWidth,
                            toggleWidth,
                            toggleWidth
                          ],
                          cornerRadius: 10,
                          initialLabelIndex: _varP,
                          totalSwitches: 3,
                          inactiveFgColor: Color(0xccbbbbbb),
                          labels: [
                            'No pulse',
                            '<100 beats per minute',
                            '>100 beats per minute'
                          ],
                          customTextStyles: [
                            TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ],
                          activeBgColors: [
                            [Color.fromARGB(255, 184, 89, 89)],
                            [Color.fromARGB(255, 227, 208, 122)],
                            [Color.fromARGB(255, 110, 205, 101)],
                          ],
                          inactiveBgColor: Color(0xffffffff),
                          onToggle: (index) {
                            setState(() {
                              _varP = index!;
                              _scoreAPGAR = _varA1 +
                                  _varP +
                                  _varG +
                                  _varA2 +
                                  _varR;
                            });
                          },
                          radiusStyle: true,
                        );
                      }),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Grimace when stimulated",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Image.asset('assets/apgar_grimace.png', height: 100),
                    const SizedBox(height: 10),
                    Container(
                      width: double.maxFinite,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xccbbbbbb),
                              offset: Offset(0, 3),
                              blurRadius: 5),
                        ],
                      ),
                      child: LayoutBuilder(builder:
                          (BuildContext context,
                          BoxConstraints constraints) {
                        double toggleWidth =
                            (constraints.maxWidth - 2) / 3;
                        return ToggleSwitch(
                          dividerColor: Colors.grey,
                          customWidths: [
                            toggleWidth,
                            toggleWidth,
                            toggleWidth
                          ],
                          cornerRadius: 10,
                          initialLabelIndex: _varG,
                          totalSwitches: 3,
                          inactiveFgColor: Color(0xccbbbbbb),
                          labels: [
                            'No response',
                            'Grimace or feeble cry',
                            'Sneezing, coughing, or pulling away'
                          ],
                          customTextStyles: [
                            TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ],
                          activeBgColors: [
                            [Color.fromARGB(255, 184, 89, 89)],
                            [Color.fromARGB(255, 227, 208, 122)],
                            [Color.fromARGB(255, 110, 205, 101)],
                          ],
                          inactiveBgColor: Color(0xffffffff),
                          onToggle: (index) {
                            setState(() {
                              _varG = index!;
                              _scoreAPGAR = _varA1 +
                                  _varP +
                                  _varG +
                                  _varA2 +
                                  _varR;
                            });
                          },
                          radiusStyle: true,
                        );
                      }),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Activity",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Image.asset('assets/apgar_activity.png', height: 100),
                    const SizedBox(height: 10),
                    Container(
                      width: double.maxFinite,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xccbbbbbb),
                              offset: Offset(0, 3),
                              blurRadius: 5),
                        ],
                      ),
                      child: LayoutBuilder(builder:
                          (BuildContext context,
                          BoxConstraints constraints) {
                        double toggleWidth =
                            (constraints.maxWidth - 2) / 3;
                        return ToggleSwitch(
                          dividerColor: Colors.grey,
                          customWidths: [
                            toggleWidth,
                            toggleWidth,
                            toggleWidth
                          ],
                          cornerRadius: 10,
                          initialLabelIndex: _varA2,
                          totalSwitches: 3,
                          inactiveFgColor: Color(0xccbbbbbb),
                          labels: [
                            'No movement',
                            'Some movement',
                            'Active movement'
                          ],
                          customTextStyles: [
                            TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ],
                          activeBgColors: [
                            [Color.fromARGB(255, 184, 89, 89)],
                            [Color.fromARGB(255, 227, 208, 122)],
                            [Color.fromARGB(255, 110, 205, 101)],
                          ],
                          inactiveBgColor: Color(0xffffffff),
                          onToggle: (index) {
                            setState(() {
                              _varA2 = index!;
                              _scoreAPGAR = _varA1 +
                                  _varP +
                                  _varG +
                                  _varA2 +
                                  _varR;
                            });
                          },
                          radiusStyle: true,
                        );
                      }),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Respirations",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Image.asset('assets/apgar_respiration.png', height: 100),
                    const SizedBox(height: 10),
                    Container(
                      width: double.maxFinite,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xccbbbbbb),
                              offset: Offset(0, 3),
                              blurRadius: 5),
                        ],
                      ),
                      child: LayoutBuilder(builder:
                          (BuildContext context,
                          BoxConstraints constraints) {
                        double toggleWidth =
                            (constraints.maxWidth - 2) / 3;
                        return ToggleSwitch(
                          dividerColor: Colors.grey,
                          customWidths: [
                            toggleWidth,
                            toggleWidth,
                            toggleWidth
                          ],
                          cornerRadius: 10,
                          initialLabelIndex: _varR,
                          totalSwitches: 3,
                          inactiveFgColor: Color(0xccbbbbbb),
                          labels: [
                            'No breathing',
                            'Weak, slow, or irregular breathing',
                            'Strong cry'
                          ],
                          customTextStyles: [
                            TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ],
                          activeBgColors: [
                            [Color.fromARGB(255, 184, 89, 89)],
                            [Color.fromARGB(255, 227, 208, 122)],
                            [Color.fromARGB(255, 110, 205, 101)],
                          ],
                          inactiveBgColor: Color(0xffffffff),
                          onToggle: (index) {
                            setState(() {
                              _varR = index!;
                              _scoreAPGAR = _varA1 +
                                  _varP +
                                  _varG +
                                  _varA2 +
                                  _varR;
                            });
                          },
                          radiusStyle: true,
                        );
                      }),
                    ),
                  ],
                ),
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


class APGARMenu extends StatefulWidget {

  final String header;
  final String subHeader;
  final String timeInterval;
  final int A;
  final int P;
  final int G;
  final int A2;
  final int R;

  const APGARMenu({Key? key,
    required this.header,
    required this.subHeader,
    required this.timeInterval,
    required this.A,
    required this.P,
    required this.G,
    required this.A2,
    required this.R,
  }) : super(key: key);

  @override
  State<APGARMenu> createState() => _APGARMenuState();
}


class _APGARMenuState extends State<APGARMenu> {

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
      category: 'APGAR',
      header: widget.header,
      subHeader: widget.subHeader,
      interval: "${_minuteIntervalList[_minuteInterval]} min",
      status: 2,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          StandardEntry(
            Color(0xffFFCDCF),
            Color(0xff8B3E42),
            Icons.calculate_rounded,
            widget.header,
            widget.subHeader,
            "${_minuteIntervalList[_minuteInterval]} min",
            2,
            DateFormat.Hm().format(DateTime.now()), // TODO sync with real time
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
          SizedBox(height: 20),
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
            child: KybeleSolidButton("Log APGAR score"),
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

