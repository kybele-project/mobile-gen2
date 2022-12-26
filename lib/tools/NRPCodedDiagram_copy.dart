import 'package:flutter/material.dart';
import 'package:kybele_gen2/nav/header.dart';

class NRPCodedDiagram extends StatelessWidget {
  const NRPCodedDiagram({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          child: Column(children: [
        PopUpHeader(
          'NRP Flow Chart',
          Icon(Icons.account_tree_rounded, color: Colors.redAccent, size: 30),
        ),
        Expanded(
            child: InteractiveViewer(
                minScale: 0.1,
                maxScale: 2.8,
                child: Container(
                  width: MediaQuery.of(context).size.width * .95,
                  height: MediaQuery.of(context).size.height * .8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/NsRPFlowChart.jpg'),
                    ),
                  ),
                ))),
      ])),
    );
  }
}
