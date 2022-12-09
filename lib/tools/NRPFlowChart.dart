import 'package:flutter/material.dart';


class NRPFlowChart extends StatelessWidget {
  const NRPFlowChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
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
              SizedBox(height: 8),
              Image(
                height: 500,
                image: AssetImage('assets/CroppedFlow.jpg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}