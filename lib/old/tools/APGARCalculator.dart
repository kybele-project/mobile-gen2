import 'package:flutter/material.dart';
import 'package:kybele_gen2/nav/header.dart';


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
    Color.fromARGB(255, 184, 89, 89),
    Color.fromARGB(255, 227, 208, 122),
    Color.fromARGB(255, 110, 205, 101),
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
            PopUpHeader(
              'APGAR Calculator',
              Icon(Icons.calculate_rounded, color: Colors.lightGreen, size: 30),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(

                              child:
                              normal ? Text("$_scoreAPGAR", style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w900, color: Colors.green))
                                     : (
                                          watch ? Text("$_scoreAPGAR", style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w900, color: Colors.amber))
                                                : Text("$_scoreAPGAR", style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w900, color: Colors.redAccent))
                                       ),
                            ),

                              Flexible(

                                child: normal ? Text("Normal", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold,), textAlign: TextAlign.center)
                                              : (
                                                  watch ? Text("Further monitoring\nrequired", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.right)
                                                      : Text("Immediate medical\nattention needed", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.right)
                                                ),
                              ),

                          ],
                        ),
                        SizedBox(height: 10),
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