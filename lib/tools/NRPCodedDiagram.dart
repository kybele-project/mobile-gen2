import 'package:flutter/material.dart';

class NRPCodedDiagram extends StatelessWidget {
  const NRPCodedDiagram({Key? key}) : super(key: key);

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
                      Text("NRP Flow Chart", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                    ],
                  ),
                  InteractiveViewer(
                    minScale: 0.1,
                    maxScale: 1.6,
                    child: Image(
                                height: 700,
                                image: AssetImage('assets/CroppedFlow.jpg'),
                              ),
                  ),
                ],
              ),
          ),
        ),
    );
  }
}