import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../components/button.dart';
import '../components/timeline.dart';
import '../databases/record_database.dart';
import '../models/event.dart';
import '../components/customtoggleswitch.dart';
import '../providers/record_provider.dart';
import '../templates/page/page.dart';


class APGARCalculator2 extends StatefulWidget {
  const APGARCalculator2({super.key});

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
  int _intervalIndex = 0;

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

    return KybelePage.fixedWithHeader(
      hasBottomActionButton: true,
      hasHeaderIcon: true,
      hasHeaderClose: true,
      bodyWidget: body(context),
      headerText: "Record",
      headerIcon: Icons.calculate_rounded,
      headerIconBkgColor: const Color(0xffFFCDCF),
      headerIconColor: const Color(0xff8B3E42),
      bottomButtonText: "Log APGAR score",
      bottomButtonMenuWidget: buttonMenu(context),
    );
  }

  Widget buttonMenu(context) {
    final recordProvider = Provider.of<RecordProvider>(context);

    Event apgarEvent = Event(
      category: 'APGAR',
      header: 'APGAR Score: $_scoreAPGAR',
      subHeader: 'A: $_varA1, P: $_varP, G: $_varG, A: $_varA2, R: $_varR',
      interval: _dropdownValue,
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: (_scoreAPGAR >= 7)
                              ? Text("$_scoreAPGAR",
                              style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.green))
                              : ((_scoreAPGAR >= 5)
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
                        Flexible(
                          child: (_scoreAPGAR >= 7)
                              ? Text("Normal",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center)
                              : ((_scoreAPGAR >= 5)
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.grey[100],
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 85),
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
    );
  }
}
