import 'package:flutter/material.dart';


class TargetOxygenSaturation extends StatelessWidget {
  const TargetOxygenSaturation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            "Target Oxygen Saturation",
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
                              Navigator.of(context).pop(),
                            }
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Column (
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: Color(0xffeaeaea)
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Table(
                      border: TableBorder.symmetric(inside: BorderSide(width: 1, color: Color(0xffeaeaea))),
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
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Text("Time Elapsed", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Text("Oxygen Saturation Level", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Text("1 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                ),
                              ),
                              TableCell(
                                child: Container(
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
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child: Text("2 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              ),
                            ),
                            TableCell(
                              child: Container(
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
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Text("3 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                ),
                              ),
                              TableCell(
                                child: Container(
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
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Text("4 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                ),
                              ),
                              TableCell(
                                child: Container(
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
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Text("5 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                ),
                              ),
                              TableCell(
                                child: Container(
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
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Text("10 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Text("85% - 95%", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
                                ),
                              ),
                            ]
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(30),
                width: double.infinity,
                color: Colors.grey[300],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OxygenRecord(),
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


class OxygenRecord extends StatefulWidget {

  @override
  State<OxygenRecord> createState() => _OxygenRecordState();

}


class _OxygenRecordState extends State<OxygenRecord> {

  double _currentSliderValue = 50;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_currentSliderValue.round().toString() + "%"),
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
                    "No recent target oxygen saturation measurements",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                    )
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}