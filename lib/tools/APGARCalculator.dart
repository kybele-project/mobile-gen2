import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:kybele_gen2/main.dart';








const List<Widget> textP = <Widget>[
  Text('No pulse', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500), maxLines: 3),
  Text('<100 beats/minute', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500), maxLines: 3),
  Text('>100 beats/minute', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500), maxLines: 3),
];


const List<Widget> textG = <Widget>[
  Text('No response', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500), maxLines: 3),
  Text('Grimace or feeble cry', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500), maxLines: 3),
  Text('Sneezing, coughing, or pulling away', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500), maxLines: 3),
];


const List<Widget> textA2 = <Widget>[
  Text('No movement', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
  Text('Some movement', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
  Text('Active movement', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
];


const List<Widget> textR = <Widget>[
  Text('No breathing', textAlign: TextAlign.center,style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
  Text('Weak, slow, or irregular breathing', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
  Text('Strong cry', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
];


class APGARCalculator extends StatefulWidget {
  const APGARCalculator({super.key});

  @override
  State<APGARCalculator> createState() => _APGARCalculatorState();
}

class _APGARCalculatorState extends State<APGARCalculator> {


  int _scoreAPGAR = 10;
  int _varA1 = 2;
  int _varP = 2;
  int _varG = 2;
  int _varA2 = 2;
  int _varR = 2;


  final List<bool> _selectedA1 = <bool>[false, false, true];
  final List<bool> _selectedP = <bool>[false, false, true];
  final List<bool> _selectedG = <bool>[false, false, true];
  final List<bool> _selectedA2 = <bool>[false, false, true];
  final List<bool> _selectedR = <bool>[false, false, true];


  final List<String> promptsA1 = [
    'Blue all over',
    'Blue only at extremities',
    'No blue coloration',
  ];


  final List<Color>colors_list = [
    const Color(0xffb71c1c),
    const Color(0xfffdd835),
    const Color(0xff2e7d32),
  ];


  final List<Color>color_text_list = [
    Colors.white,
    Colors.black,
    Colors.white,
  ];


  Widget getTabWidget(String title, bool isTabSelected, int index){
    return isTabSelected
        ? Container(
            width: double.infinity,
            height: double.infinity,
            color: colors_list[index],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: color_text_list[index],
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3
                ),
                Text(
                  "(+$index)",
                  style: TextStyle(
                    fontSize: 10,
                    color: color_text_list[index],
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3
                ),
                Text(
                  "(+$index)",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 64) / 3;
    final normal = (_scoreAPGAR >= 7);
    final watch = (_scoreAPGAR  >= 5);

    String _varA1String = _varA1.toString();
    String _varPString = _varP.toString();
    String _varGString = _varG.toString();
    String _varA2String = _varA2.toString();
    String _varRString = _varR.toString();


    return Material(
      child: SafeArea(
        child: Column(
          children: [
              Container(
                width: double.infinity,
                color: Colors.white, //Color(0xfff6f6f6),
                padding: EdgeInsets.fromLTRB(30,20,30,20),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "APGAR Calculator",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          // Text(completion_percent, style: TextStyle(color: Colors.black, fontSize: 14,),),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            color: Colors.black,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: const Icon(Icons.info_outline_rounded),
                            onPressed: () => {
                              deactivate(),
                              Navigator.of(context).pop(),
                            }
                          ),
                          const SizedBox(width: 30),
                          IconButton(
                              color: Colors.black,
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () => {
                                deactivate(),
                                Navigator.of(context).pop(),
                              }
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: Column (
                      children: [
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child:
                              normal ? Text("$_scoreAPGAR", style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.green))
                                     : (
                                          watch ? Text("$_scoreAPGAR", style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.amber))
                                                : Text("$_scoreAPGAR", style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.redAccent))
                                       ),
                            ),
                            const SizedBox(width: 40),
                            Flexible(
                              child: normal ? Text("Normal", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                                            : (
                                                watch ? Text("Further monitoring required", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                                                    : Text("Immediate medical attention needed", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Appearance",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _varA1String,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ToggleButtons(
                          direction: Axis.horizontal,
                          onPressed: (int index) {
                            setState(() {
                              // The button that is tapped is set to true, and the others to false.
                              _varA1 = index;
                              for (int i = 0; i < _selectedA1.length; i++) {
                                _selectedA1[i] = i == index;
                              }
                              _scoreAPGAR = _varA1 + _varP + _varG + _varA2 + _varR;
                            });
                          },
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          selectedBorderColor: const Color(0xffeaeaea),
                          disabledBorderColor: const Color(0xffeaeaea),
                          constraints: BoxConstraints(
                            minHeight: width/1.75,
                            minWidth: width,
                            maxHeight: width/1.75,
                            maxWidth: width,
                          ),
                          isSelected: _selectedA1,
                          children: [
                            getTabWidget('Blue all over', _selectedA1[0], 0),
                            getTabWidget('Blue only at extremities', _selectedA1[1], 1),
                            getTabWidget('No blue coloration', _selectedA1[2], 2),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Pulse",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _varPString,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ToggleButtons(
                          direction: Axis.horizontal,
                          onPressed: (int index) {
                            setState(() {
                              // The button that is tapped is set to true, and the others to false.
                              _varP = index;
                              for (int i = 0; i < _selectedP.length; i++) {
                                _selectedP[i] = i == index;
                              }
                              _scoreAPGAR = _varA1 + _varP + _varG + _varA2 + _varR;
                            });
                          },
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          selectedBorderColor: const Color(0xffeaeaea),
                          disabledBorderColor: const Color(0xffeaeaea),
                          constraints: BoxConstraints(
                            minHeight: width/1.75,
                            minWidth: width,
                            maxHeight: width/1.75,
                            maxWidth: width,
                          ),
                          isSelected: _selectedP,
                          children: [
                            getTabWidget('No pulse', _selectedP[0], 0),
                            getTabWidget('<100 beats per minute', _selectedP[1], 1),
                            getTabWidget('>100 beats per minute', _selectedP[2], 2),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Grimace when stimulated",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _varGString,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ToggleButtons(
                          direction: Axis.horizontal,
                          onPressed: (int index) {
                            setState(() {
                              // The button that is tapped is set to true, and the others to false.
                              _varG = index;
                              for (int i = 0; i < _selectedG.length; i++) {
                                _selectedG[i] = i == index;
                              }
                              _scoreAPGAR = _varA1 + _varP + _varG + _varA2 + _varR;
                            });
                          },
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          selectedBorderColor: const Color(0xffeaeaea),
                          disabledBorderColor: const Color(0xffeaeaea),
                          constraints: BoxConstraints(
                            minHeight: width/1.75,
                            minWidth: width,
                            maxHeight: width/1.75,
                            maxWidth: width,
                          ),
                          isSelected: _selectedG,
                          children: [
                            getTabWidget('No response', _selectedG[0], 0),
                            getTabWidget('Grimace or feeble cry', _selectedG[1], 1),
                            getTabWidget('Sneezing, coughing, or pulling away', _selectedG[2], 2),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Activity",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _varA2String,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ToggleButtons(
                          direction: Axis.horizontal,
                          onPressed: (int index) {
                            setState(() {
                              // The button that is tapped is set to true, and the others to false.
                              _varA2 = index;
                              for (int i = 0; i < _selectedA2.length; i++) {
                                _selectedA2[i] = i == index;
                              }
                              _scoreAPGAR = _varA1 + _varP + _varG + _varA2 + _varR;
                            });
                          },
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          selectedBorderColor: const Color(0xffeaeaea),
                          disabledBorderColor: const Color(0xffeaeaea),
                          constraints: BoxConstraints(
                            minHeight: width/1.75,
                            minWidth: width,
                            maxHeight: width/1.75,
                            maxWidth: width,
                          ),
                          isSelected: _selectedA2,
                          children: [
                            getTabWidget('No movement', _selectedA2[0], 0),
                            getTabWidget('Some movement', _selectedA2[1], 1),
                            getTabWidget('Active movement', _selectedA2[2], 2),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Respiration",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _varRString,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ToggleButtons(
                          direction: Axis.horizontal,
                          onPressed: (int index) {
                            setState(() {
                              // The button that is tapped is set to true, and the others to false.
                              _varR = index;
                              for (int i = 0; i < _selectedR.length; i++) {
                                _selectedR[i] = i == index;
                              }
                              _scoreAPGAR = _varA1 + _varP + _varG + _varA2 + _varR;
                            });
                          },
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          selectedBorderColor: const Color(0xffeaeaea),
                          disabledBorderColor: const Color(0xffeaeaea),
                          constraints: BoxConstraints(
                            minHeight: width/1.75,
                            minWidth: width,
                            maxHeight: width/1.75,
                            maxWidth: width,
                          ),
                          isSelected: _selectedR,
                          children: [
                            getTabWidget('No breathing', _selectedR[0], 0),
                            getTabWidget('Weak, slow, or irregular breathing', _selectedR[1], 1),
                            getTabWidget('Strong cry', _selectedR[2], 2),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xffeaeaea),
                            )
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  "Add to record",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16
                                  )
                                ),
                                Text(
                                    "No recent APGAR calculations",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                      ],
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}