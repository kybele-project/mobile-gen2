import 'package:flutter/material.dart';

import 'package:kybele_gen2/tools/tools_routing.dart';
import 'package:kybele_gen2/learn/video_library.dart';
import 'package:kybele_gen2/nav/navigator_keys.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:kybele_gen2/firebase_options.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const MyApp());
}

// Test Git
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.openSansTextTheme(
        //textTheme: GoogleFonts.ibmPlexSansTextTheme(
          Theme.of(context).textTheme
        ),
      ),
      home: const Framework(),
    );
  }
}


class Framework extends StatefulWidget {

  final int customIndex;
  const Framework(
    {this.customIndex = 1}
  );

  @override
  State<Framework> createState() => _FrameworkState();
}

class _FrameworkState extends State<Framework> {


  int _selectedIndex = 1;


  List<Widget> _widgetOptions = <Widget>[
    Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Text(
          'History!!!',
        ),
      ),
    ),
    Tools(),
    Learn(),

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


  GlobalKey<NavigatorState> _navigatorKey() {
    switch(_selectedIndex) {
      case 0:
        return NavigatorKeys.record;
      case 1:
        return NavigatorKeys.tools;
      default:
        return NavigatorKeys.learn;
    }
  }



  @override
  Widget build(BuildContext context) {
          return Scaffold(
                backgroundColor: Color(0xfff6f6f6),
                bottomNavigationBar: BottomNavigationBar(
                  unselectedItemColor: Colors.white70,
                  selectedItemColor: Colors.white,
                  elevation: 20,
                  backgroundColor: Colors.blueGrey[700],
                  items:[
                    BottomNavigationBarItem(icon: Icon(Icons.list_alt_rounded), label: "Record"),
                    BottomNavigationBarItem(icon: Icon(Icons.handyman_rounded), label: "Tools"),
                    BottomNavigationBarItem(icon: Icon(Icons.school_rounded), label: "Learn"),
                  ],
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  selectedFontSize: 12,
                  unselectedFontSize: 12,

                ),
                body: IndexedStack(
                  index: _selectedIndex,
                  children: _widgetOptions,
                ),
          );
  }
}
