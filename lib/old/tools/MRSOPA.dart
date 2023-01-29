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
                        0: FixedColumnWidth(70),
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
                                    "",
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
                                    "ACTIONS",
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
                                  child: Text("M", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text.rich(
                                    TextSpan(
                                        style: TextStyle(color: Colors.black), //apply style to all
                                        children: [
                                          TextSpan(text: 'Adjust ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
                                          TextSpan(text: 'Mask ', style: TextStyle(fontSize:14, fontWeight: FontWeight.w800)),
                                          TextSpan(text: 'to assure good seal on the face', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300))
                                        ]
                                      )
                                  ),
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
                                child: Text("R.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                color: Colors.grey[50],
                                padding: EdgeInsets.all(8),
                                alignment: Alignment.center,
                                child: Text.rich(
                                    TextSpan(
                                        style: TextStyle(color: Colors.black), //apply style to all
                                        children: [
                                          TextSpan(text: 'Reposition ', style: TextStyle(fontSize:14, fontWeight: FontWeight.w800)),
                                          TextSpan(text: 'airway by adjusting head to "sniffing" position', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300))
                                        ]
                                      )
                                  ),
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
                                  child: Text("S", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text.rich(
                                    TextSpan(
                                        style: TextStyle(color: Colors.black), //apply style to all
                                        children: [
                                          TextSpan(text: 'Suction ', style: TextStyle(fontSize:14, fontWeight: FontWeight.w800)),
                                          TextSpan(text: 'mouth and nose of secretions, if present', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300))
                                        ]
                                      )
                                  ),
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
                                  child: Text("O", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  color: Colors.grey[50],
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text.rich(
                                    TextSpan(
                                        style: TextStyle(color: Colors.black), //apply style to all
                                        children: [
                                          TextSpan(text: 'Open ', style: TextStyle(fontSize:14, fontWeight: FontWeight.w800)),
                                          TextSpan(text: 'mouth slightly and move jaw forward', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300))
                                        ]
                                      )
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
                                  child: Text("P", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  
                                  color: Colors.white,
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  child: Text.rich(
                                    TextSpan(
                                        style: TextStyle(color: Colors.black), //apply style to all
                                        children: [
                                          TextSpan(text: 'Increase', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
                                          TextSpan(text: ' Pressure', style: TextStyle(fontSize:14, fontWeight: FontWeight.w800)),
                                          TextSpan(text: ' to achieve chest rise', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300))
                                        ]
                                      )
                                  ),
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
                                  child: Text("A", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  color: Colors.grey[50],
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text.rich(
                                    TextSpan(
                                        style: TextStyle(color: Colors.black), //apply style to all
                                        children: [
                                          TextSpan(text: 'Consider', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
                                          TextSpan(text: ' Airway', style: TextStyle(fontSize:14, fontWeight: FontWeight.w800)),
                                          TextSpan(text: ' alternative (endotracheal intubation or laryngeal mask airway)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300))
                                        ]
                                      )
                                  ),
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