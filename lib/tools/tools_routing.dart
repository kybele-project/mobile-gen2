import 'package:flutter/material.dart';

import 'package:kybele_gen2/tools/APGARCalculator.dart';
import 'package:kybele_gen2/tools/TargetOxygenSaturation.dart';
import 'package:kybele_gen2/tools/NRPCodedDiagram.dart';

import 'package:kybele_gen2/nav/header.dart';

import 'package:firebase_auth/firebase_auth.dart';


class ToolsRoutes {
  static const String root = "/tools/";
  static const String apgarCalc = "/tools/apgar/";
  static const String nrpFlow = "/tools/nrpflow/";
  static const String targetO2 = "/tools/targeto2/";
}


class Tools extends StatelessWidget {

  static final GlobalKey<NavigatorState> toolsKey = GlobalKey();

  List<Widget> toolsIcons = <Widget>[
    Icon(Icons.account_tree_rounded, color: Colors.red, size: 70,),
    Icon(Icons.calculate_rounded, color: Colors.green, size: 70,),
    Icon(Icons.bubble_chart_rounded, color: Colors.blue, size: 70,),
  ];

  List<Widget> toolsLabels = <Widget>[
    const Text('NRP Flow Chart', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    const Text('APGAR Calculator', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    const Text('Target Oxygen Saturation', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), maxLines: 2),
  ];

  List<dynamic> toolsNav = <dynamic> [
    const NRPCodedDiagram(),
    const APGARCalculator(),
    const TargetOxygenSaturation(),
  ];


  void _local_push(BuildContext context, Widget widget) {
    Navigator.of(toolsKey.currentContext!).push(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      ToolsRoutes.root: (context) => _home(context),
      ToolsRoutes.nrpFlow: (context) => NRPCodedDiagram(),
      ToolsRoutes.apgarCalc: (context) => APGARCalculator(),
      ToolsRoutes.targetO2: (context) => TargetOxygenSaturation(),
    };
  }

  Widget _home(BuildContext context) {
    return Material(
      child: SafeArea(
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              return Column(
                children: [
                  Header(),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                                color: Color(0xfff6f6f6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Tools", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
                          sliver: SliverGrid(
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200.0,
                              mainAxisSpacing: 20.0,
                              crossAxisSpacing: 20.0,
                              childAspectRatio: 1.0,
                            ),
                            delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    _local_push(context, toolsNav[index]);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Color(0xffeaeaea),
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        toolsIcons[index],
                                        toolsLabels[index],
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
