import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kybele_gen2/record/alarm.dart';

// import 'package:kybele_gen2/tools/APGARCalculator.dart';
import 'package:kybele_gen2/tools/TargetOxygenSaturation.dart';
import 'package:kybele_gen2/tools/NRPCodedDiagram.dart';
import 'package:kybele_gen2/tools/MRSOPA.dart';
import 'package:kybele_gen2/tools/APGAR2.dart';
import 'package:kybele_gen2/record/alarm.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:animations/animations.dart';
import 'package:kybele_gen2/tools/AdditionalResources.dart';

class ToolsRoutes {
  static const String root = "/tools/";
  static const String apgarCalc = "/tools/apgar/";
  static const String nrpFlow = "/tools/nrpflow/";
  static const String targetO2 = "/tools/targeto2/";
  static const String pdfViewer = "/tools/pdfViewer";
  static const String alarm = "/tools/alarm";
}

class Tools extends StatelessWidget {
  static final GlobalKey<NavigatorState> toolsKey = GlobalKey();

  List<Widget> toolsIcons = <Widget>[
    Icon(
      Icons.account_tree_rounded,
      color: Colors.white,
      size: 80,
    ),
    Icon(
      Icons.calculate_rounded,
      color: Colors.white,
      size: 80,
    ),
    Icon(
      Icons.bubble_chart_rounded,
      color: Colors.white,
      size: 80,
    ),
    Icon(
      Icons.air_rounded,
      color: Colors.white,
      size: 80,
    ),
    // PDF VIEWER LOGO
    Icon(
      Icons.drive_file_move_outline,
      color: Colors.white,
      size: 80,
    ),
    Icon(
      Icons.watch_later_rounded,
      color: Colors.white,
      size: 80,
    ),
  ];

  List<String> toolsLabels = [
    'NRP Flow Chart',
    'APGAR Calculator',
    'Target Oxygen Saturation',
    'MR. SOPA\n Corrective Steps',
    // PDF VIEWER NAME
    'Additional Resources',
    'Alarm',
  ];

  List<dynamic> toolsNav = <dynamic>[
    const NRPCodedDiagram(),
    const APGARCalculator2(),
    const TargetOxygenSaturation(),
    MRSOPA(),
    // PDF VIEWER CLASS
    const PDFViewer(),
    CountUpTimerPage(),
    // APGARCalculator2(),
  ];

  Widget generate_card(BuildContext context, int index, Color color) {
    double side = (MediaQuery.of(context).size.width - 60) / 2;
    double begin = MediaQuery.of(context).size.width / 1.5 - side / 2;

    double topPos = begin + ((index - index % 2) / 2) * (side + 20);
    double leftPos = 20 + (index % 2) * (side + 20);

    return
      // child: GestureDetector(
      // onTap: () {_local_push(context, toolsNav[index]);},
Container(margin: const EdgeInsets.all(5.0), child:
OpenContainer(
            closedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            closedColor: color,
            transitionType: ContainerTransitionType.fadeThrough,
            transitionDuration: const Duration(milliseconds: 200),
            openBuilder: (context, action) => toolsNav[index],
            closedBuilder: (context, action) => Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  toolsIcons[index],
                  SizedBox(height: 15),
                  Text(
                    toolsLabels[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        ),
                    maxLines: 2,
                  ),
                ],
              ),
            )));
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      ToolsRoutes.root: (context) => _home(context),
      ToolsRoutes.nrpFlow: (context) => NRPCodedDiagram(),
      ToolsRoutes.apgarCalc: (context) => APGARCalculator2(),
      ToolsRoutes.targetO2: (context) => TargetOxygenSaturation(),
    };
  }

  Widget _home(BuildContext context) {
    double side = (MediaQuery.of(context).size.width - 60) / 2;
    double begin = MediaQuery.of(context).size.width / 1.5 - side / 2;
    double len_grey = 2 * (side + 20) + side / 2 + 40;

    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child:
              Column( children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(40),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/kybele_logo_no_bg.png',
                      height: 40,
                    ),
                  ],
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal:5, vertical: 5),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children:[
                generate_card(context, 0, Color.fromARGB(255, 184, 61, 55)),
                generate_card(context, 1, Color.fromARGB(255, 103, 189, 72)),
                generate_card(context, 2, Color.fromARGB(255, 83, 187, 213)),
                generate_card(context, 4, Color.fromARGB(255, 111, 29, 149)),
              ]))
              ]
        ),
      )
    ));
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    return Navigator(
      key: toolsKey,
      initialRoute: ToolsRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context));
      },
    );
  }
}
