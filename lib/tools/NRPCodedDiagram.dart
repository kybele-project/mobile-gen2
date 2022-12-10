import 'package:flutter/material.dart';

class NRPCodedDiagram extends StatelessWidget {
  const NRPCodedDiagram({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
          child: Column(
          children: [
            Container(
                width: double.infinity,
                color: Colors.white, //Color(0xfff6f6f6),
                padding: EdgeInsets.fromLTRB(30,20,30,20),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "NRP Flowchart",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                          // Text(completion_percent, style: TextStyle(color: Colors.black, fontSize: 14,),),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            color: Colors.black,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: const Icon(Icons.info_outline_rounded),
                            onPressed: () => {
                              Navigator.of(context).pop(),
                            }
                          ),
                          const SizedBox(width: 30),
                          IconButton(
                              color: Colors.black,
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () => {
                                Navigator.of(context).pop(),
                              }
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            SingleChildScrollView( child:
            Container (
                child:
                    InteractiveViewer(
                    minScale: 0.1,
                    maxScale: 2.2,
                    child:
                    Container(
                      width: MediaQuery.of(context).size.width*.95,
                      height: MediaQuery.of(context).size.height*.8,
                      decoration: 
                      BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/NRPFlowChart.jpg'),
                        ),
                      ),
                    )
                    )
                
              ),
            )
          ] 
          )
        ),
    );
  }
}