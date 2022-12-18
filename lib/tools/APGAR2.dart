import 'package:flutter/material.dart';
import 'package:kybele_gen2/nav/header.dart';
import 'package:kybele_gen2/designs/customtoggleswitch.dart';


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


class APGARCalculator2 extends StatefulWidget {
  const APGARCalculator2({super.key});

  @override
  State<APGARCalculator2> createState() => _APGARCalculatorState2();
}

class _APGARCalculatorState2 extends State<APGARCalculator2> {


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
    Color.fromARGB(255, 184, 89, 89),
    Color.fromARGB(255, 227, 208, 122),
    Color.fromARGB(255, 110, 205, 101),
  ];





  @override
  Widget build(BuildContext context) {
    final normal = (_scoreAPGAR >= 7);
    final watch = (_scoreAPGAR  >= 5);

    return Material(
      child: SafeArea(
        child: Column(
          children: [
            PopUpHeader(
              'APGAR Calculator 2',
              Icon(Icons.calculate_rounded, color: Colors.lightGreen, size: 30),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        border: Border(
                          bottom: BorderSide(color: Color(0xffeaeaea), width: 1)
                        )
                      ),

                      child: Padding(
                        padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                          child: Column (
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(

                                    child:
                                    normal ? Text("$_scoreAPGAR", style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w900, color: Colors.green))
                                        : (
                                        watch ? Text("$_scoreAPGAR", style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w900, color: Colors.amber))
                                            : Text("$_scoreAPGAR", style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w900, color: Colors.redAccent))
                                    ),
                                  ),

                                  Flexible(

                                    child: normal ? Text("Normal", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold,), textAlign: TextAlign.center)
                                        : (
                                        watch ? Text("Further monitoring\nrequired", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.right)
                                            : Text("Immediate medical\nattention needed", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.right)
                                    ),
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
                        padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                        child: Column (
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
                                    BoxShadow(color: Color(0xccbbbbbb), offset: Offset(0,3), blurRadius: 5),
                                  ],
                                ),
                                child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      double toggleWidth = (constraints.maxWidth - 2)/3;
                                      return ToggleSwitch(
                                        dividerColor: Colors.grey,
                                        customWidths: [toggleWidth, toggleWidth, toggleWidth],
                                        cornerRadius: 10,
                                        initialLabelIndex: _varA1,
                                        totalSwitches: 3,
                                        inactiveFgColor: Color(0xccbbbbbb),
                                        labels: ['Blue all over', 'Blue only at\nextremities', 'No blue\ncoloration'],
                                        customTextStyles: [
                                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                                            _scoreAPGAR = _varA1 + _varP + _varG + _varA2 + _varR;
                                          });
                                        },
                                        radiusStyle: true,
                                      );
                                    }
                                ),
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
                                    BoxShadow(color: Color(0xccbbbbbb), offset: Offset(0,3), blurRadius: 5),
                                  ],
                                ),
                                child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      double toggleWidth = (constraints.maxWidth - 2)/3;
                                      return ToggleSwitch(
                                        dividerColor: Colors.grey,
                                        customWidths: [toggleWidth, toggleWidth, toggleWidth],
                                        cornerRadius: 10,
                                        initialLabelIndex: _varP,
                                        totalSwitches: 3,
                                        inactiveFgColor: Color(0xccbbbbbb),
                                        labels: ['No pulse', '<100 beats per minute', '>100 beats per minute'],
                                        customTextStyles: [
                                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                                            _scoreAPGAR = _varA1 + _varP + _varG + _varA2 + _varR;
                                          });
                                        },
                                        radiusStyle: true,
                                      );
                                    }
                                ),
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
                                    BoxShadow(color: Color(0xccbbbbbb), offset: Offset(0,3), blurRadius: 5),
                                  ],
                                ),
                                child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      double toggleWidth = (constraints.maxWidth - 2)/3;
                                      return ToggleSwitch(
                                        dividerColor: Colors.grey,
                                        customWidths: [toggleWidth, toggleWidth, toggleWidth],
                                        cornerRadius: 10,
                                        initialLabelIndex: _varG,
                                        totalSwitches: 3,
                                        inactiveFgColor: Color(0xccbbbbbb),
                                        labels: ['No response', 'Grimace or feeble cry', 'Sneezing, coughing, or pulling away'],
                                        customTextStyles: [
                                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                                            _scoreAPGAR = _varA1 + _varP + _varG + _varA2 + _varR;
                                          });
                                        },
                                        radiusStyle: true,
                                      );
                                    }
                                ),
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
                                    BoxShadow(color: Color(0xccbbbbbb), offset: Offset(0,3), blurRadius: 5),
                                  ],
                                ),
                                child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      double toggleWidth = (constraints.maxWidth - 2)/3;
                                      return ToggleSwitch(
                                        dividerColor: Colors.grey,
                                        customWidths: [toggleWidth, toggleWidth, toggleWidth],
                                        cornerRadius: 10,
                                        initialLabelIndex: _varA2,
                                        totalSwitches: 3,
                                        inactiveFgColor: Color(0xccbbbbbb),
                                        labels: ['No movement', 'Some movement', 'Active movement'],
                                        customTextStyles: [
                                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                                            _scoreAPGAR = _varA1 + _varP + _varG + _varA2 + _varR;
                                          });
                                        },
                                        radiusStyle: true,
                                      );
                                    }
                                ),
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
                                    BoxShadow(color: Color(0xccbbbbbb), offset: Offset(0,3), blurRadius: 5),
                                  ],
                                ),
                                child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      double toggleWidth = (constraints.maxWidth - 2)/3;
                                      return ToggleSwitch(
                                        dividerColor: Colors.grey,
                                        customWidths: [toggleWidth, toggleWidth, toggleWidth],
                                        cornerRadius: 10,
                                        initialLabelIndex: _varR,
                                        totalSwitches: 3,
                                        inactiveFgColor: Color(0xccbbbbbb),
                                        labels: ['No breathing', 'Weak, slow, or irregular breathing', 'Strong cry'],
                                        customTextStyles: [
                                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                                            _scoreAPGAR = _varA1 + _varP + _varG + _varA2 + _varR;
                                          });
                                        },
                                        radiusStyle: true,
                                      );
                                    }
                                ),
                              ),
                              const SizedBox(height: 15),
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
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),

                            ],
                          )
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