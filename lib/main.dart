import 'package:flutter/material.dart';
import 'package:kybele_gen2/tools/APGAR2.dart';
import 'package:kybele_gen2/tools/NRPCodedDiagram.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:kybele_gen2/learn/video_page.dart';
import 'package:kybele_gen2/learn/modules.dart';

import 'package:kybele_gen2/log/backend.dart';
import 'dart:core';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:vibration/vibration.dart';

import 'package:kybele_gen2/log/button.dart';
import 'package:kybele_gen2/log/timeline.dart';
import 'package:kybele_gen2/log/timer_metadata.dart';
import 'package:kybele_gen2/tools/TargetOxygenSaturation.dart';
import 'package:kybele_gen2/tools/AdditionalResources.dart';

import 'main2.dart';


Future<void> main() async {
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecordProvider(),
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
            textTheme: GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme),
          ),
          home: const Framework(),
        );
      }),
    );
  }
}

class Framework extends StatefulWidget {
  final int customIndex;
  const Framework({this.customIndex = 0});

  @override
  State<Framework> createState() => _FrameworkState();
}

class _FrameworkState extends State<Framework> {

  int _selectedIndex= 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff7266D7),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey[600],
        selectedItemColor: Color(0xff564BAF),
        elevation: 0,
        backgroundColor: Color(0xffffffff), // Colors.black54,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded), label: "Record"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 16,
        unselectedFontSize: 16,
      ),
      body: [HomePage(), RecordPages()][_selectedIndex]
    );
  }
}
