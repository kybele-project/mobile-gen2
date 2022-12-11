import 'package:flutter/material.dart';

import 'package:kybele_gen2/nav/header.dart';


class MRSOPA extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            PopUpHeader(
              'MR. SOPA Corrective Steps',
              Icon(
                Icons.air_rounded,
                color: Colors.deepPurpleAccent[100],
                size: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
              child: Column (
                children: [
                  Container(
                    child: Table(
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
                                    color: Colors.grey[200],
                                  ),
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "ELAPSED TIME",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "TARGET OXYGEN SATURATION",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
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
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text("1 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(8),
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
                                color: Colors.grey[50],
                                padding: EdgeInsets.all(8),
                                alignment: Alignment.center,
                                child: Text("2 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                color: Colors.grey[50],
                                padding: EdgeInsets.all(8),
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
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text("3 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(8),
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
                                  color: Colors.grey[50],
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text("4 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  color: Colors.grey[50],
                                  padding: EdgeInsets.all(8),
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
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text("5 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(8),
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
                                  color: Colors.grey[50],
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text("10 min", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  color: Colors.grey[50],
                                  padding: EdgeInsets.all(8),
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
          ],
        ),
      ),
    );
  }
}