import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:core';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';



NumberFormat timeFormat = NumberFormat("00");

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.child,
    this.color,
    this.disableColor,
    this.elevation,
    this.side = BorderSide.none,
    this.onTap,
    super.key,
  });

  final Widget child;
  final Color? color;
  final Color? disableColor;
  final double? elevation;
  final BorderSide side;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: color,
        shape: const StadiumBorder().copyWith(side: side),
        disabledBackgroundColor: disableColor ?? Colors.grey,
        elevation: elevation,
      ),
      onPressed: onTap,
      child: child,
    );
  }
}

class NextEvent extends StatefulWidget {
  const NextEvent({super.key});

  @override
  State<NextEvent> createState() =>
      _NextEventState();
}

class _NextEventState extends State<NextEvent>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 83),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Circular progress indicator with a fixed color',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            CircularProgressIndicator(
              value: controller.value,
              color: Colors.deepOrange,
              semanticsLabel: 'Circular progress indicator',
            ),
          ],
        ),
      ),
    );
  }
}









class CountUpTimerPage extends StatefulWidget {
  static Future<void> navigatorPush(BuildContext context) async {
    return Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => CountUpTimerPage(),
      ),
    );
  }

  @override
  _State createState() => _State();
}

class _State extends State<CountUpTimerPage> {
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onStopped: () {
      print('onStop');
    },
    onEnded: () {
      print('onEnded');
    },
  );

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));
    _stopWatchTimer.fetchStopped
        .listen((value) => print('stopped from stream'));
    _stopWatchTimer.fetchEnded.listen((value) => print('ended from stream'));

    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimer.setPresetTime(mSec: 1234);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  StreamBuilder ElapsedTime() {
    List<ValueStream<int>> stopwatchTimerStreamList = [
      _stopWatchTimer.minuteTime,
      _stopWatchTimer.secondTime
    ];

    return StreamBuilder<List<int>>(
        stream: CombineLatestStream.list(stopwatchTimerStreamList),
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshotList) {
          final minute = snapshotList.data![0];
          final second = snapshotList.data![1] % 60;
          return Text(timeFormat.format(minute) + ":" + timeFormat.format(second),
              style: const TextStyle(fontSize: 70));
        }
    );
  }

  StreamBuilder NextEventTimer(int eventMinute, int eventSecond, int gap) {

    num eventTime = eventMinute * 60 + eventSecond;

    List<ValueStream<int>> stopwatchTimerStreamList = [
      _stopWatchTimer.minuteTime,
      _stopWatchTimer.secondTime,
    ];

    return StreamBuilder<int>(
        stream: _stopWatchTimer.secondTime,
        builder: (BuildContext context, snap) {

          num secondDiff = (eventTime - snap.data!);
          num minuteDiff = (secondDiff / 60).floor();

          if (secondDiff < 0) {
            minuteDiff = 0;
            secondDiff = 0;
          }
          else {
            secondDiff %= 60;
          }

          return Column(
            children: [
              Text(minuteDiff.toString() + ":" + timeFormat.format(secondDiff),
                  style: const TextStyle(fontSize: 30,
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.bold)),
            ],
          );
        }
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                NextEvent(),
                /// Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: RoundedButton(
                        color: Colors.lightBlue,
                        onTap: _stopWatchTimer.onStartTimer,
                        child: const Text(
                          'Start',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: RoundedButton(
                        color: Colors.green,
                        onTap: _stopWatchTimer.onStopTimer,
                        child: const Text(
                          'Stop',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: RoundedButton(
                        color: Colors.red,
                        onTap: _stopWatchTimer.onResetTimer,
                        child: const Text(
                          'Reset',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(0).copyWith(right: 8),
                        child: RoundedButton(
                          color: Colors.deepPurpleAccent,
                          onTap: _stopWatchTimer.onAddLap,
                          child: const Text(
                            'Lap',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
    );
  }
}