import 'package:flutter/material.dart';


const List<Widget> textA1 = <Widget>[
  Text('Blue all over (+0)', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
  Text('Blue only at extremities (+1)', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
  Text('No blue coloration (+2)', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
];

const List<Widget> textP = <Widget>[
  Text('No pulse (+0)', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
  Text('<100 beats/minute (+1)', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
  Text('>100 beats/minute (+2)', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
];

const List<Widget> textG = <Widget>[
  Text('No response (+0)', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
  Text('Grimace or feeble cry (+1)', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
  Text('Sneezing, coughing, or pulling away (+2)', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
];

const List<Widget> textA2 = <Widget>[
  Text('No movement (+0)', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
  Text('Some movement (+1)', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
  Text('Active movement (+2)', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
];

const List<Widget> textR = <Widget>[
  Text('No breathing (+0)', textAlign: TextAlign.center,style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
  Text('Weak, slow, or irregular breathing (+1)', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
  Text('Strong cry (+2)', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), maxLines: 3),
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

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 84) / 3;
    final normal = (_scoreAPGAR >= 7);

    return Material(
      child: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(40),
            child: Column (
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(alignment: Alignment.centerLeft, child: GestureDetector(child: Icon(Icons.arrow_circle_left, size: 32, color: Color(0xFF7B212D)), onTap: Navigator.of(context).pop)),
                    SizedBox(width: 20),
                    Text("APGAR Calculator", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                  ],
                ),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child:
                        normal ? Text("$_scoreAPGAR", style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.lightGreen))
                            : Text("$_scoreAPGAR", style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.redAccent),),
                      ),
                      SizedBox(width: 40),
                      Flexible(
                        child: normal ? Text("Normal", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),) : Text("Immediate medical attention needed", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
                      ),
                    ],
                  ),
                ),
                Text("Appearance", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(height: 8,),
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
                  selectedBorderColor: Color(0xFF7B212D),
                  selectedColor: Colors.white,
                  fillColor: Color(0xFF7B212D),
                  color: Color(0xFF7B212D),
                  constraints: BoxConstraints(
                    minHeight: width/1.75,
                    minWidth: width,
                    maxHeight: width/1.75,
                    maxWidth: width,
                  ),
                  isSelected: _selectedA1,
                  children: textA1,
                ),
                SizedBox(height: 20),
                Text("Pulse", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                SizedBox(height: 8,),
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
                  selectedBorderColor: Color(0xFF7B212D),
                  selectedColor: Colors.white,
                  fillColor: Color(0xFF7B212D),
                  color: Color(0xFF7B212D),
                  constraints: BoxConstraints(
                    minHeight: width/1.75,
                    minWidth: width,
                    maxHeight: width/1.75,
                    maxWidth: width,
                  ),
                  isSelected: _selectedP,
                  children: textP,
                ),
                SizedBox(height: 20),
                Text("Grimace (when stimulated)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(height: 8,),
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
                  selectedBorderColor: Color(0xFF7B212D),
                  selectedColor: Colors.white,
                  fillColor: Color(0xFF7B212D),
                  color: Color(0xFF7B212D),
                  constraints: BoxConstraints(
                    minHeight: width/1.75,
                    minWidth: width,
                    maxHeight: width/1.75,
                    maxWidth: width,
                  ),
                  isSelected: _selectedG,
                  children: textG,
                ),
                SizedBox(height: 20),
                Text("Activity", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(height: 8,),
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
                  selectedBorderColor: Color(0xFF7B212D),
                  selectedColor: Colors.white,
                  fillColor: Color(0xFF7B212D),
                  color: Color(0xFF7B212D),
                  constraints: BoxConstraints(
                    minHeight: width/1.75,
                    minWidth: width,
                    maxHeight: width/1.75,
                    maxWidth: width,
                  ),
                  isSelected: _selectedA2,
                  children: textA2,
                ),
                SizedBox(height: 20),
                Text("Respiration", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(height: 8,),
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
                  selectedBorderColor: Color(0xFF7B212D),
                  selectedColor: Colors.white,
                  fillColor: Color(0xFF7B212D),
                  color: Color(0xFF7B212D),
                  constraints: BoxConstraints(
                    minHeight: width/1.75,
                    minWidth: width,
                    maxHeight: width/1.75,
                    maxWidth: width,
                  ),
                  isSelected: _selectedR,
                  children: textR,
                ),
              ],
            )
        ),
      ),
    );
  }
}