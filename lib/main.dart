import 'package:flutter/material.dart';
import 'package:kybele_gen2/record/record_screen.dart';

import 'package:kybele_gen2/tools/tools_routing.dart';
import 'package:kybele_gen2/learn/video_library.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:kybele_gen2/firebase_options.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:kybele_gen2/provider/dbprovider.dart';

import 'package:animations/animations.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DBProvider(),
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
            // textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
          ),
          home: const Framework(),
        );
      }),
    );
  }
}

class Framework extends StatefulWidget {
  final int customIndex;
  const Framework({this.customIndex = 1});

  @override
  State<Framework> createState() => _FrameworkState();
}

class _FrameworkState extends State<Framework> {
  int _selectedIndex = 1;

  List<Widget> _widgetOptions = <Widget>[
    RecordRouter(),
    Tools(),
    LearnRouter(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.customIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white70,
        selectedItemColor: Colors.white,
        elevation: 20,
        backgroundColor: Color(0xff005660), // Colors.black54,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded), label: "Record"),
          BottomNavigationBarItem(
              icon: Icon(Icons.handyman_rounded), label: "Tools"),
          BottomNavigationBarItem(
              icon: Icon(Icons.school_rounded), label: "Learn"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 14,
        unselectedFontSize: 14,
      ),
      body: PageTransitionSwitcher(
          duration: Duration(milliseconds: 500),
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
              FadeThroughTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  child: child),
          child: _widgetOptions[_selectedIndex]),
    );
  }
}
