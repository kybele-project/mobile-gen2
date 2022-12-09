import 'package:flutter/material.dart';


class TargetOxygenSaturation extends StatelessWidget {
  const TargetOxygenSaturation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Expanded(
                    child: Text("Target Oxygen Saturation", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32), maxLines: 2,),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Table(
                  border: TableBorder.symmetric(inside: BorderSide(width: 1)),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(100),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text("1 min", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text("60% - 65%", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
                            ),
                          ),
                        ]
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text("2 min", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text("65% - 70%", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text("3 min", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text("70% - 75%", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
                            ),
                          ),
                        ]
                    ),
                    TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text("4 min", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text("75% - 80%", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
                            ),
                          ),
                        ]
                    ),
                    TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text("5 min", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text("80% - 85%", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
                            ),
                          ),
                        ]
                    ),
                    TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text("10 min", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text("85% - 95%", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
                            ),
                          ),
                        ]
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}