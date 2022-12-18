import 'dart:math';

import 'package:flutter/material.dart';

// import 'package:kybele_gen2/tools/APGARCalculator.dart';
import 'package:kybele_gen2/tools/TargetOxygenSaturation.dart';
import 'package:kybele_gen2/tools/NRPCodedDiagram.dart';
import 'package:kybele_gen2/tools/MRSOPA.dart';
import 'package:kybele_gen2/tools/APGAR2.dart';

import 'package:firebase_auth/firebase_auth.dart';


import 'package:animations/animations.dart';


class ToolsRoutes {
  static const String root = "/tools/";
  static const String apgarCalc = "/tools/apgar/";
  static const String nrpFlow = "/tools/nrpflow/";
  static const String targetO2 = "/tools/targeto2/";
}


class Tools extends StatelessWidget {

  static final GlobalKey<NavigatorState> toolsKey = GlobalKey();

  List<Widget> toolsIcons = <Widget>[
    Icon(Icons.account_tree_rounded, color: Colors.redAccent, size: 80,),
    Icon(Icons.calculate_rounded, color: Colors.lightGreen, size: 80,),
    Icon(Icons.bubble_chart_rounded, color: Colors.lightBlueAccent, size: 80,),
    Icon(Icons.air_rounded, color: Colors.deepPurpleAccent[100], size: 80,),
  ];

  List<String> toolsLabels = [
    'NRP Flow Chart',
    'APGAR Calculator',
    'Target Oxygen Saturation',
    'MR. SOPA\n Corrective Steps',
  ];

  List<dynamic> toolsNav = <dynamic> [
    const NRPCodedDiagram(),
    const APGARCalculator2(),
    const TargetOxygenSaturation(),
    MRSOPA(),
    // APGARCalculator2(),
  ];




  Widget generate_card(BuildContext context, int index, Color color) {

    double side = (MediaQuery.of(context).size.width - 60)/2;
    double begin = MediaQuery.of(context).size.width/1.5 - side/2;

    double topPos = begin + ((index - index % 2)/2) * (side + 20);
    double leftPos = 20 + (index % 2) * (side + 20);

    return Positioned(
      top: topPos,
      left: leftPos,
      // child: GestureDetector(
      // onTap: () {_local_push(context, toolsNav[index]);},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(color: Color(0xccbbbbbb), offset: Offset(0,3), blurRadius: 5),
          ],
        ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: OpenContainer(
              transitionType: ContainerTransitionType.fadeThrough,
              transitionDuration: const Duration(milliseconds: 200),
              openBuilder: (context, action) => toolsNav[index],
              closedBuilder: (context, action) => Container(
                height: side,
                width: side,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    toolsIcons[index],
                    SizedBox(height: 10),
                    Text(
                      toolsLabels[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                      maxLines: 2,),
                  ],
                ),
              ),

            ),
            //),
          ),
        ),
      );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      ToolsRoutes.root: (context) => _home(context),
      ToolsRoutes.nrpFlow: (context) => NRPCodedDiagram(),
      ToolsRoutes.apgarCalc: (context) => APGARCalculator2(),
      ToolsRoutes.targetO2: (context) => TargetOxygenSaturation(),
    };
  }

  Widget tealContainer(BuildContext context) {
    return                         Container(
      height: MediaQuery.of(context).size.width/1.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          // teal
          colors: [Color(0xff005660), Color(0xff007475), Color(0xff008081), Color(0xff229389), Color(0xff34A798), Color(0xff57C3AD),],
          // sunset
          // colors: [Color(0xff7d2c4c), Color(0xffac3d63), Color(0xffca4a67), Color(0xffe55a59),],
        ),
      ),
    );
  }

  Widget _home(BuildContext context) {

    double side = (MediaQuery.of(context).size.width - 60)/2;
    double begin = MediaQuery.of(context).size.width/1.5 - side/2;
    double len_grey = 2 * (side + 20) + side/2 + 40;

    return Material(
      child: SafeArea(
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        tealContainer(context),
                        Container(color: Colors.grey[200], height: len_grey),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: begin,
                      padding: EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/kybele_white.png',
                            height: 40,
                          ),
                          Text(
                            "Tools",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                    generate_card(context, 0, Colors.redAccent),
                    generate_card(context, 1, Colors.redAccent),
                    generate_card(context, 2, Colors.redAccent),
                    generate_card(context, 3, Colors.redAccent),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    return Navigator(
      key: toolsKey,
      initialRoute: ToolsRoutes.root,

      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context)
        );
      },
    );
  }
}


