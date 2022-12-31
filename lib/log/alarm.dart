import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:vibration/vibration.dart';
import 'package:kybele_gen2/log/recordProvider.dart';
import 'package:kybele_gen2/log/timeline.dart';


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

  String timerPaused = 'Timer assistant paused';
  String timerPausedAudio = 'assets/timer_audio/timerPaused.wav';
  String timerStopped = 'Timer assistant stopped';
  String timerStoppedAudio = 'assets/timer_audio/timerStopped.wav';

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
  bool _historyCollapsed = true;

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

    final recordProvider = Provider.of<RecordProvider>(context);

    return Scaffold(
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
                    num seconds = ((snap.data ?? 0) / 1000).floor();
                    if (_stopWatchStarted && (seconds == timerLocations[timerAudioIndex + 1])) {
                      timerAudioIndex = timerAudioIndex + 1;
                      Vibration.vibrate(pattern: [0, 200, 200, 200, 200, 200]);
                      FlutterRingtonePlayer.play(
                          fromAsset: timerAudioFiles[timerAudioIndex]);
                    }
                    num minutes = (seconds / 60).floor();
                    num secondDisplay = (seconds % 60);

                    return Stack(
                      children:[
                        LinearProgressIndicator(
                          value: ((snap.data ?? 0) - timerLocations[timerAudioIndex] * 1000)/(timerGaps[timerAudioIndex] * 1000),
                          minHeight: MediaQuery.of(context).size.width,
                          backgroundColor: const Color(0xff7266D7),
                          color: const Color(0xff564BAF),
                        ),
                        _historyCollapsed ? Container(
                            width: double.maxFinite,
                            height: MediaQuery.of(context).size.width * .7,
                            padding: const EdgeInsets.fromLTRB(30,20,30,20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    "${timeFormat.format(minutes)}:${timeFormat.format(secondDisplay)}",
                                    style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                _stopWatchStarted ? Text(
                                  timerAudioStrings[timerAudioIndex],
                                  style: const TextStyle(fontSize: 22, color: Color(0xfff5f5f5)),
                                  textAlign: TextAlign.center,
                                ) :
                                const Text(
                                  'Press play\nto start',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xfff5f5f5),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RawMaterialButton(
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      onPressed: () {
                                        if (_stopWatchStarted) {
                                          _stopWatchTimer.onStopTimer();
                                          Event timerEvent = Event(
                                              category: 'Timer',
                                              header: 'Timer paused',
                                              subHeader: "Let's go!!!",
                                              interval: 'None'
                                          );
                                          recordProvider.addEvent(timerEvent);
                                          FlutterRingtonePlayer.play(fromAsset: timerPausedAudio);
                                        }
                                        else {
                                          _stopWatchTimer.onStartTimer();
                                          Event timerEvent = Event(
                                              category: 'Timer',
                                              header: 'Timer started',
                                              subHeader: "Let's go!!!",
                                              interval: 'None'
                                          );
                                          recordProvider.addEvent(timerEvent);
                                          FlutterRingtonePlayer.play(fromAsset: timerAudioFiles[0]);
                                        }
                                        setState(() => {_stopWatchStarted = !_stopWatchStarted});

                                      },
                                      elevation: 0,
                                      fillColor: const Color(0xff9F97E3),
                                      padding: const EdgeInsets.all(15.0),
                                      shape: const CircleBorder(),
                                      child: !_stopWatchStarted
                                          ? const Icon(Icons.play_arrow_rounded, size: 30.0, color: Colors.white)
                                          : const Icon(Icons.stop_rounded, size: 30.0, color: Colors.white),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  _historyCollapsed = !_historyCollapsed;
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
                                      Text("${timeFormat.format(minutes)}:${timeFormat.format(secondDisplay)}",
                                          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                                      RawMaterialButton(
                                        onPressed: () {
                                          if (_stopWatchStarted) {
                                            _stopWatchTimer.onStopTimer();
                                            Event timerEvent = Event(
                                                category: 'Timer',
                                                header: 'Timer paused',
                                                subHeader: "Let's go!!!",
                                                interval: 'None'
                                            );
                                            recordProvider.addEvent(timerEvent);
                                            FlutterRingtonePlayer.play(fromAsset: timerPausedAudio);
                                          }
                                          else {
                                            _stopWatchTimer.onStartTimer();
                                            Event timerEvent = Event(
                                              category: 'Timer',
                                              header: 'Timer started',
                                              subHeader: "Let's go!!!",
                                              interval: 'None'
                                            );
                                            recordProvider.addEvent(timerEvent);
                                            FlutterRingtonePlayer.play(fromAsset: timerAudioFiles[0]);
                                          }
                                          setState(() => {_stopWatchStarted = !_stopWatchStarted});

                                        },
                                        elevation: 0,
                                        fillColor: const Color(0xff9F97E3),
                                        padding: const EdgeInsets.all(10),
                                        shape: const CircleBorder(),
                                        child: !_stopWatchStarted
                                            ? const Icon(Icons.play_arrow_rounded, size: 30.0, color: Colors.white)
                                            : const Icon(Icons.stop_rounded, size: 30.0, color: Colors.white),
                                      ),
                                    ],
                                  )
                              ),
                        ),
                      ],
                    );
                  }, //
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: _historyCollapsed
                    ? MediaQuery.of(context).size.width * .7
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
                                    child: Text('Record', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _historyCollapsed = !_historyCollapsed;
                                    });
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    width: 100,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: _historyCollapsed
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
                      )
                    )
                )
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x00ffffff),
                          Color(0x88f5f5f5),
                        ],
                      ),
                    ),
                  )
                ),
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
                                    const Text(
                                      'Log event',
                                      style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      width: double.maxFinite,
                                      padding: const EdgeInsets.all(20),
                                      decoration: const BoxDecoration(
                                        color: Color(0xffFFCDCF),
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.calculate_rounded, size: 40, color: Color(0xff8B3E42)),
                                          SizedBox(width: 15),
                                          Text(
                                            "APGAR Score",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color(0xff8B3E42)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      width: double.maxFinite,
                                      padding: const EdgeInsets.all(20),
                                      decoration: const BoxDecoration(
                                        color: Color(0xffE2EEF9),
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.bubble_chart_rounded,
                                            size: 40,
                                            color: Color(0xff436B8F),
                                          ),
                                          SizedBox(width: 15),
                                          Text(
                                            "Oxygen Saturation",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                color: Color(0xff436B8F)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                            border: Border.all(width: 2, color: const Color(0xff9F97E3))
                                        ),
                                        width: MediaQuery.of(context).size.width - 40,
                                        height: 60,
                                        child: const Center(
                                          child: Text('Cancel',
                                            style: TextStyle(color: Color(0xff9F97E3), fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                        );
                      },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff564BAF),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      width: MediaQuery.of(context).size.width - 40,
                      height: 60,
                      child: const Center(
                        child: Text(
                          'Log event',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}