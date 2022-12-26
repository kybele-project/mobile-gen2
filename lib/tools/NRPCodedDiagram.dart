import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kybele_gen2/nav/header.dart';

TextTheme menuText = GoogleFonts.ptSansTextTheme();

class NRPCodedDiagram extends StatelessWidget {
  const NRPCodedDiagram({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(
                      color: Color(0xffeaeaea),
                      width: 1,
                    ))),
                child: Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.account_tree_rounded,
                                  color: Colors.redAccent, size: 30),
                              const SizedBox(width: 20),
                              const Text("NRP Flow Chart",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          IconButton(
                              color: Colors.black,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () => {
                                    Navigator.of(context).pop(),
                                  }),
                        ],
                      ),
                      TabBar(
                        labelColor: Colors.grey[500],
                        tabs: [
                          Tab(child: Text('Flow Chart')),
                          Tab(icon: Icon(Icons.directions_transit)),
                          Tab(icon: Icon(Icons.directions_bike)),
                        ],
                      ),
                    ],
                  ),
                ),
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
                            image: AssetImage('assets/NRPFlowChart.jpg'),
                          ),
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
