import 'package:flutter/material.dart';
import 'package:kybele_gen2/tools/APGAR2.dart';
import 'package:kybele_gen2/tools/NRPCodedDiagram.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:kybele_gen2/tools/video_library.dart';

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

  late int _selectedIndex;

  int _timerStage = 0;

  bool _fresh = true;
  bool _active = false;
  bool _passedStage = false;
  bool _recordCollapsed = false;
  bool _showStopButton = false;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void initState() {
    _selectedIndex = widget.customIndex;
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  bool timerIsLate() {
    if (_timerStage == timerGaps.length) {
      return true;
    }
    else {
      return false;
    }
  }

  void timerUpdateStage(num currSeconds) {
    if (timerIsLate()) return;

    if (_active) {
      num nextStage = timerLocations[_timerStage] + timerGaps[_timerStage];

      if (currSeconds == nextStage) {
        Vibration.vibrate(pattern: [0, 200, 200, 200, 200, 200]);
        FlutterRingtonePlayer.play(fromAsset: timerActiveAudio[_timerStage]);
        _timerStage++;
        _passedStage = true;
      }
    }
  }

  String timerCurrentString() {
    if (_active) {
      if (_passedStage) {
        return timerActiveMessages[_timerStage - 1];
      }
      return _fresh ? timerStartedMessage : timerResumedMessage;
    }
    return _fresh ? timerStoppedMessage : timerPausedMessage;
  }

  void timerStart() {
    _stopWatchTimer.onStartTimer();

    setState(() {
      _active = true;
      _showStopButton = true;
    });

    if (_fresh) {

      final recordProvider = Provider.of<RecordProvider>(context, listen: false);
      Event timerEvent = Event(
          category: 'Timer',
          header: 'Timer started',
          subHeader: "Let's go!!!",
          interval: 'None'
      );
      recordProvider.addEvent(timerEvent);

      FlutterRingtonePlayer.play(fromAsset: timerStartedAudio);
    }
    else {
      final recordProvider = Provider.of<RecordProvider>(context, listen: false);
      Event timerEvent = Event(
          category: 'Timer',
          header: 'Timer resumed',
          subHeader: "Let's go!!!",
          interval: 'None'
      );
      recordProvider.addEvent(timerEvent);

      FlutterRingtonePlayer.play(fromAsset: timerResumedAudio);
    }
  }

  void timerPause() {
    _stopWatchTimer.onStopTimer();

    setState(() {
      _active = false;
      _fresh = false;
    });

    final recordProvider = Provider.of<RecordProvider>(context, listen: false);
    Event timerEvent = Event(
        category: 'Timer',
        header: 'Timer paused',
        subHeader: "Let's go!!!",
        interval: 'None'
    );
    recordProvider.addEvent(timerEvent);

    FlutterRingtonePlayer.play(fromAsset: timerPausedAudio);
  }

  void timerStopAndReset() {
    _stopWatchTimer.onResetTimer();

    setState(() {
      _fresh = true;
      _passedStage = false;
      _showStopButton = false;
      _timerStage = 0;
    });

    final recordProvider = Provider.of<RecordProvider>(context, listen: false);
    Event timerEvent = Event(
        category: 'Timer',
        header: 'Timer stopped',
        subHeader: "Let's go!!!",
        interval: 'None'
    );
    recordProvider.addEvent(timerEvent);

    FlutterRingtonePlayer.play(fromAsset: timerStoppedAudio);
  }

  Widget timerInteractionButtons(BuildContext context) {

    double paddingWidth;
    MainAxisAlignment rowAlign;

    if (_recordCollapsed) {
      paddingWidth = 20;
      rowAlign = MainAxisAlignment.center;
    }
    else {
      paddingWidth = 10;
      rowAlign = MainAxisAlignment.end;
    }

    return Row(
      mainAxisAlignment: rowAlign,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RawMaterialButton(
            onPressed: () {
              _active ? timerPause() : timerStart();
            },
            elevation: 0,
            fillColor: const Color(0xff9F97E3),
            padding: EdgeInsets.all(paddingWidth),
            shape: const CircleBorder(),
            child: _active
                ? const Icon(Icons.pause_rounded, size: 30, color: Colors.white)
                : const Icon(Icons.play_arrow_rounded, size: 30, color: Colors.white)
        ),
        (!_active && _showStopButton)
            ? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: paddingWidth),
            RawMaterialButton(
              onPressed: () {
                timerStopAndReset();
              },
              elevation: 0,
              fillColor: const Color(0xff9F97E3),
              padding: EdgeInsets.all(paddingWidth),
              shape: const CircleBorder(),
              child: const Icon(Icons.stop_rounded, size: 30, color: Colors.white),
            ),
          ],
        ) : Container(),
      ],
    );
  }

  Widget home2(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: _showStopButton ? MediaQuery.of(context).size.width * .2 : 0),
        Expanded(
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: _showStopButton ? const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ) : const BorderRadius.all(Radius.circular(0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,20,0),
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                                alignment: Alignment.centerLeft,
                                height: MediaQuery.of(context).size.width * .2,
                                child: Image.asset(
                                    'assets/kybele_purple.png',
                                    height: 60,
                                    fit: BoxFit.fitHeight,
                                  ),
                              ),
                            ],
                          ),
                        ),
                        SliverGrid.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 1,
                          children: [
                            KybeleColorfulTile(
                              Color(0xffFFCDCF),
                              Color(0xff8B3E42),
                              Icons.calculate_rounded,
                              'APGAR Calculator',
                              APGARCalculator2(),
                            ),
                            KybeleColorfulTile(
                              Color(0xffE2EEF9),
                              Color(0xff436B8F),
                              Icons.bubble_chart_rounded,
                              'Oxygen Saturation',
                              TargetOxygenSaturation(),
                            ),
                            KybeleColorfulTile(
                              Color(0xfff9d8b9),
                              Color(0xff9B5717),
                              Icons.account_tree_rounded,
                              'NRP Algorithm',
                              NRPCodedDiagram(),
                            ),
                            KybeleColorfulTile(
                              Color(0xffE2F9E3),
                              Color(0xff69976B),
                              Icons.video_library_rounded,
                              'Training Videos',
                              Learn2(),
                            ),
                          ],
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate([SizedBox(height: 20)]),
                        ),
                        SliverGrid.count(
                            crossAxisCount: 1,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 5,
                            children: [
                              KybelePDFTile(
                                "NRP Checklist",
                                RenderScreen(
                                  "NRP Checklist",
                                  "assets/NRPQuickEquipmentChecklist.pdf",
                                ),
                              ),
                              KybelePDFTile(
                                "A4 NRP Checklist",
                                RenderScreen(
                                  "A4 NRP Checklist",
                                  "assets/A4 - NRP Checklist 27Oct2022.pdf",
                                ),
                              ),
                              KybelePDFTile(
                                "T-Piece Resuscitator for Lamination",
                                RenderScreen(
                                  "T-Piece Resuscitator for Lamination",
                                  "assets/T-Piece resuscitator for lamination.pdf",
                                ),
                              ),
                              KybelePDFTile(
                                "Warmilu Thermal Gel Instructions",
                                RenderScreen(
                                  "A4 NRP Checklist",
                                  "assets/Warmilu_thermal gel autoclave instructions.pdf",
                                ),
                              ),

                            ]
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


  Widget record(BuildContext context) {

    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: _recordCollapsed
                ? MediaQuery.of(context).size.width * .8
                : MediaQuery.of(context).size.width * .2),
            Expanded(
              child: Container(
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20,0,20,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              'Record',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _recordCollapsed = !_recordCollapsed;
                              });
                            },
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              width: 100,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: _recordCollapsed
                                    ? const Icon(Icons.unfold_more_rounded, size: 28)
                                    : const Icon(Icons.unfold_less_rounded, size: 28),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Timeline(),
                            SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            const KybeleButtonGradientLayer(),
            Positioned(
              bottom: 10,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text('Log event', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 20),
                              const KybeleColorfulButton(Color(0xffFFCDCF), Color(0xff8B3E42), Icons.calculate_rounded, 'APGAR Score', APGARCalculator2()),
                              const SizedBox(height: 20),
                              const KybeleColorfulButton(Color(0xffE2EEF9), Color(0xff436B8F), Icons.bubble_chart_rounded, 'Oxygen Saturation', TargetOxygenSaturation()),
                              const SizedBox(height: 20),
                              GestureDetector(onTap: () => {Navigator.pop(context)}, child: const KybeleOutlineButton('Cancel')),
                            ],
                          ),
                        );
                      }
                  );
                },
                child: const KybeleSolidButton('Log event'),
              ),
            ),
          ],
        ),
      ],
    );
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _recordCollapsed = (_selectedIndex == 0) ? false : true;
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
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StreamBuilder<int>(
                    stream: _stopWatchTimer.rawTime,
                    builder: (BuildContext context, snap) {
                      num totalSeconds = ((snap.data ?? 0) / 1000).floor();
                      num minutes = (totalSeconds / 60).floor();
                      num seconds = (totalSeconds % 60);

                      timerUpdateStage(totalSeconds);

                      return Stack(
                        children:[
                          LinearProgressIndicator(
                            value: (timerIsLate()) ? 1 : ((snap.data ?? 0) - timerLocations[_timerStage] * 1000)/(timerGaps[_timerStage] * 1000),
                            minHeight: MediaQuery.of(context).size.width * 1.5,
                            backgroundColor: const Color(0xff7266D7),
                            color: const Color(0xff564BAF),
                          ),
                          _recordCollapsed ? Container(
                            width: double.maxFinite,
                            height: MediaQuery.of(context).size.width * .8,
                            padding: const EdgeInsets.fromLTRB(30,20,30,20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${timeFormat.format(minutes)}:${timeFormat.format(seconds)}",
                                  style: const TextStyle(fontSize: 100, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                Text(
                                  timerCurrentString(),
                                  style: const TextStyle(fontSize: 30, color: Color(0xfff5f5f5)),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                timerInteractionButtons(context),
                              ],
                            ),
                          )
                              : GestureDetector(
                            onTap: () {
                              setState(() {
                                _recordCollapsed = !_recordCollapsed;
                                _selectedIndex = 1;
                              });
                            },
                            child: Container(
                                color: Colors.transparent,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * .2,
                                padding: const EdgeInsets.fromLTRB(20,0,0,0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${timerNumberFormat.format(minutes)}:${timerNumberFormat.format(seconds)}",
                                        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                                    timerInteractionButtons(context),
                                  ],
                                )
                            ),
                          ),
                        ],
                      );
                    }
                ),
              ],
            ),
            [home2(context), record(context)][_selectedIndex]
          ],
        ),
      ),
    );
  }
}
