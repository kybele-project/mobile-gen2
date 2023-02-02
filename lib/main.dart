import 'package:flutter/material.dart';
import 'package:kybele_gen2/providers/kybele_providers.dart';
import 'package:kybele_gen2/screens/home.dart';
import 'package:kybele_gen2/screens/record.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:core';

Future<void> main() async {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
            ChangeNotifierProvider<TimerProvider>(create: (_) => TimerProvider()),
            ChangeNotifierProvider<RecordProvider>(create: (_) => RecordProvider()),
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              useMaterial3: true,
              textTheme: GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme),
            ),
            home: const Framework(),
          ),
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
      body: [
        HomePage(),
        RecordPages()
      ][_selectedIndex]
    );
  }
}
