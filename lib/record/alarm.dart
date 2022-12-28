import 'package:flutter/material.dart';
import 'package:kybele_gen2/record/alarm.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:core';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:kybele_gen2/provider/dbprovider.dart';
import 'package:provider/provider.dart';

NumberFormat timeFormat = NumberFormat("00");

class CountUpTimerPage extends StatefulWidget {
  const CountUpTimerPage({super.key});

  @override
  State<CountUpTimerPage> createState() =>
      _CUState();
}

class _CUState extends State<CountUpTimerPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool determinate = false;
  late int timerAudioIndex;

  List<String> timerAudioFiles = [
    'assets/timer_audio/timer0.wav',
    'assets/timer_audio/timer1.wav',
    'assets/timer_audio/timer2.wav',
    'assets/timer_audio/timer3.wav',
    'assets/timer_audio/timer4.wav',
    'assets/timer_audio/timer5.wav',
    'assets/timer_audio/timer10.wav',
    'assets/timer_audio/timer15.wav',
  ];

  List<String> timerAudioStrings = [
    'Timer assistant\nstarted',
    '1 minute elapsed. Log APGAR score and oxygen saturation',
    '2 minutes elapsed. Log oxygen saturation',
    '3 minutes elapsed. Log oxygen saturation',
    '4 minutes elapsed. Log oxygen saturation',
    '5 minutes elapsed. Log APGAR score and oxygen saturation',
    '10 minutes elapsed. Log APGAR score and oxygen saturation',
    '15 minutes elapsed. Log APGAR score and oxygen saturation',
  ];

  List<int> timerGaps = [
    60, 60, 60, 60, 60, 300, 300, 0, 0
  ];

  List<int> timerLocations = [
    0, 60, 120, 180, 240, 300, 600, 900, 9000
  ];

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );
  bool _stopWatchStarted = false;

  @override
  void initState() {

    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
      value: 10,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
    timerAudioIndex = 0;
  }

  @override
  void dispose() async {
    controller.dispose();
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
          Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
                StreamBuilder<int>(
                  stream: _stopWatchTimer.secondTime,
                  builder: (BuildContext context, snap) {
                    num seconds = snap.data!;
                    if (_stopWatchStarted && (seconds == timerLocations[timerAudioIndex + 1])) {
                      timerAudioIndex = timerAudioIndex + 1;
                      Vibration.vibrate(pattern: [0, 200, 200, 200, 200, 200]);
                      FlutterRingtonePlayer.play(
                          fromAsset: timerAudioFiles[timerAudioIndex]);
                    }
                    num minutes = (seconds / 60).floor();
                    num secondDisplay = (seconds % 60);

                    print("DEBUG");
                    print(seconds);
                    print(timerAudioIndex);
                    print((seconds - timerLocations[timerAudioIndex])/timerGaps[timerAudioIndex]);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        Container(
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.width * .55,
                          padding: EdgeInsets.fromLTRB(20,20,20,20),
                          color: Colors.teal[400],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(timeFormat.format(minutes) + ":" + timeFormat.format(secondDisplay),
                                  style: const TextStyle(fontSize: 54, fontWeight: FontWeight.bold, color: Colors.white)),
                              _stopWatchStarted ? Text(
                                timerAudioStrings[timerAudioIndex],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[100],
                                ),
                                textAlign: TextAlign.center,
                              ) : Text('\n'),
                            ],
                          ),
                        ),
                        LinearProgressIndicator(
                          value: (seconds - timerLocations[timerAudioIndex])/timerGaps[timerAudioIndex],
                          minHeight: 4,
                          backgroundColor: Colors.teal[100],
                          color: Colors.teal[800],
                        ),
                      ],
                    );
                  }, //
                ),
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Consumer<DBProvider>(
                  builder: (BuildContext context, provider, widget) {
                    if (provider.events.isEmpty) {
                      return Center(child: Text("DB is empty :("));
                    } else {
                      return Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Column(
                          children: [
                            for (int i = 0; i < provider.events.length; i++)
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xccbbbbbb),
                                            offset: Offset(0, 3),
                                            blurRadius: 5),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(provider.events[
                                        provider.events.length -
                                            1 -
                                            i]
                                            .toMap()['time']),
                                        Text(
                                            provider.events[
                                            provider.events.length -
                                                1 -
                                                i]
                                                .toMap()['type'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            )),
                                        Text(
                                          provider.events[
                                          provider.events.length -
                                              1 -
                                              i]
                                              .toMap()['description'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        if (provider.events[
                                        provider.events.length -
                                            1 -
                                            i]
                                            .toMap()['type'] ==
                                            'APGAR')
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                provider.events[provider
                                                    .events.length -
                                                    1 -
                                                    i]
                                                    .toMap()['info1'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                              Text(
                                                provider.events[provider
                                                    .events.length -
                                                    1 -
                                                    i]
                                                    .toMap()['info2'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                              Text(
                                                provider.events[provider
                                                    .events.length -
                                                    1 -
                                                    i]
                                                    .toMap()['info3'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                              Text(
                                                provider.events[provider
                                                    .events.length -
                                                    1 -
                                                    i]
                                                    .toMap()['info4'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                              Text(
                                                provider.events[provider
                                                    .events.length -
                                                    1 -
                                                    i]
                                                    .toMap()['info5'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                ],
                              ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              ),
              Container(child: Text("Buttons")),

              ],
            ),
            Positioned(
                right: 20,
                top: MediaQuery.of(context).size.width * .55 - 33,
                child: RawMaterialButton(
                  onPressed: () {
                    if (_stopWatchStarted) {
                      _stopWatchTimer.onStopTimer();
                    }
                    else {
                      _stopWatchTimer.onStartTimer();
                      FlutterRingtonePlayer.play(fromAsset: timerAudioFiles[0]);
                    }
                    setState(() => {_stopWatchStarted = !_stopWatchStarted});

                  },
                  elevation: 2.0,
                  fillColor: !_stopWatchStarted ? Colors.lightGreenAccent : Colors.redAccent,
                  child: !_stopWatchStarted ? Icon(
                    Icons.play_arrow_rounded,
                    size: 30.0,
                  ) : Icon(Icons.stop_rounded, size: 30.0),
                  padding: EdgeInsets.all(20.0),
                  shape: CircleBorder(),
                )
            ),
          ],
      ),
    ),
    );
  }
}