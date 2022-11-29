import 'package:flutter/material.dart';
import 'package:kybele_gen2/screens/NRPVideos2.dart';
import 'screens/videogen2.dart';
import 'screens/APGARCalculator.dart';
import 'screens/NRPVideos.dart';
import 'screens/NRPVideos2.dart';
import 'screens/TargetOxygenSaturation.dart';

import 'screens/NRPCodedDiagram.dart';


import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

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
        textTheme: GoogleFonts.ibmPlexSansTextTheme(
          Theme.of(context).textTheme
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

List<Widget> homeIcons = <Widget>[
  Icon(Icons.account_tree_rounded, color: Colors.grey[100], size: 70,),
  Icon(Icons.calculate_rounded, color: Colors.grey[100], size: 70,),
  Icon(Icons.bubble_chart_rounded, color: Colors.grey[100], size: 70,),
  Icon(Icons.video_library_rounded, color: Colors.grey[100], size: 70,),
  Icon(Icons.video_library_rounded, color: Colors.grey[100], size: 70,),
  Icon(Icons.video_library_rounded, color: Colors.grey[100], size: 70,),
];

List<Widget> homeLabels = <Widget>[
  const Text('NRP Flow Chart', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFFFFFFFF))),
  const Text('APGAR Calculator', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFFFFFFFF))),
  const Text('Target Oxygen Saturation', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFFFFFFFF)), maxLines: 2),
  const Text('Training Videos Original', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFFFFFFFF))),
  const Text('Training Videos Test', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFFFFFFFF))),
  const Text('Training Videos New', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFFFFFFFF))),
];

List<dynamic> homeNav = <dynamic> [
  const NRPCodedDiagram(),
  const APGARCalculator(),
  const TargetOxygenSaturation(),
  NRPVideos(),
  NRPVideos2(),
  NRPVideos3(),

];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //  setState(() { _counter++; });
  // }
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return Scaffold(
                body: Padding(
                  padding: EdgeInsets.all(40),
                  child: CustomScrollView(
                    // physics: const NeverScrollableScrollPhysics(),
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget> [
                                Image(
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  image: AssetImage('assets/kybele_logo_no_bg.png'),
                                ),
                                // const Icon(Icons.settings, size: 30),
                              ],
                            ),
                            const SizedBox(height: 40),
                            snapshot.hasData ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text("Welcome back,", style: TextStyle(fontSize: 24)),
                                SizedBox(height: 10),
                                const Text("Raj Krishna Yadav", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                                SizedBox(height: 10),
                                const Text("Midwife Manager II", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100, color: Color(0xff808080))),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Color(0xFFF4C95D)),
                                  ),
                                  onPressed: () => FirebaseAuth.instance.signOut(),
                                  child: const Text('Sign out', style: TextStyle(fontSize: 18, color: Color(0xFF000000))),
                                ),
                              ],
                            ) : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text("Hello", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),
                                    const Text("Please sign in for user-specific features", style: TextStyle(fontSize: 24)),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Color(0xFFF4C95D)),
                                          ),
                                          onPressed: () => {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => LoginWidget()
                                              ),
                                            )
                                          },
                                          child: const Text('Log in', style: TextStyle(fontSize: 18, color: Color(0xFF000000))),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.grey),
                                          ),
                                          onPressed: () {},
                                          child: const Text('Apply for account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                            const SizedBox(height: 40),
                            const Center(child: Text("REFERENCE MATERIAL (NO LOG IN REQUIRED) ", style: TextStyle(fontSize: 14, color: Color(0xFF000000)))),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      SliverGrid(
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => homeNav[index]
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  // color: Colors.teal[50],
                                  gradient: const LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      // D4A0A7, CB858E
                                      // Color(0xFF7B212D),
                                      // Color(0xFF7B2E39),
                                      Color(0xFF00008B),
                                      Color(0xFF00008B),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: (Colors.grey[400])!,
                                        spreadRadius: 0,
                                        blurRadius: 0,
                                        offset: const Offset(0, 0)
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    homeIcons[index],
                                    homeLabels[index],
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: 6,
                        ),
                      ),
            ],
            ),
            ),
          );
          }
      ),
    ),
    );
  }
}

// Firebase Authentication
class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Material(
        child: Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      image: AssetImage('assets/kybele_logo_no_bg.png'),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: emailController,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(labelText: 'Password'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                      ),
                      onPressed: () {
                        signIn(context);
                        // Navigator.of(context).pop();
                      },
                    child: const Text('Log in', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                  ],
                )
            ),
      );

  Future signIn(context) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyApp()));
  }
}






