import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:kybele_gen2/components/shared_prefs.dart';
import 'package:vibration/vibration.dart';

import '../databases/timer_metadata.dart';

import 'package:shared_preferences/shared_preferences.dart';

class TimerProvider with ChangeNotifier {

  late Timer _stopwatch;

  late bool _reset;
  late bool _active;
  late bool _resumed;

  late int _milliseconds;
  late int _timerIndex;

  // shared prefs keys
  String currMillisecondsKey = "currMilliseconds";
  String resetStatusKey = "resetStatus";
  String activeStatusKey = "activeStatus";
  String resumedStatusKey = "resumedStatus";
  String currTimerIndexKey = "currTimerIndex";
  String currTimeKey = "currTimeKey";

  TimerProvider() {
    _reset = sharedPrefs.initBool(resetStatusKey, true);
    _active = sharedPrefs.initBool(activeStatusKey, false);
    _resumed = sharedPrefs.initBool(resumedStatusKey, false);

    _milliseconds = sharedPrefs.initInt(currMillisecondsKey, 0);

    if (_active) {
      int currTime = DateTime.now().millisecondsSinceEpoch;
      int prevTime = sharedPrefs.initInt(currTimeKey, 0);
      int diff = currTime - prevTime;

      _milliseconds += diff;

      _timerIndex = 0;
      num nextCheckpoint = (timerLocations2[_timerIndex] +
          timerGaps2[_timerIndex]) * 1000;

      while ((_timerIndex < timerLocations2.length) && (_milliseconds >= nextCheckpoint)) {
        _timerIndex += 1;
        nextCheckpoint = (timerLocations2[_timerIndex] + timerGaps2[_timerIndex]) * 1000;
      }

      timerActive();
    }
    else {
      _timerIndex = sharedPrefs.initInt(currTimerIndexKey, 0);
    }

    // setSharedPrefs();
  }

  int get milliseconds => _milliseconds;
  bool get active => _active;
  bool get buttonsStart => ((_reset == true) && (_active == false));
  bool get buttonsPause => ((_reset == false) && (_active == true));
  bool get buttonsContinueReset => ((_reset = false) && (_active == false));


  String fetchTime() {
    int totalSeconds = (_milliseconds/1000).floor();
    int minutes = (totalSeconds / 60).floor();
    int seconds = totalSeconds % 60;
    return "${timerNumberFormat.format(minutes)}:${timerNumberFormat.format(seconds)}";
  }

  void setSharedPrefs() {

    sharedPrefs.changeBool(resetStatusKey, _reset);
    sharedPrefs.changeBool(activeStatusKey, _active);
    sharedPrefs.changeBool(resumedStatusKey, _resumed);

    sharedPrefs.changeInt(currMillisecondsKey, _milliseconds);
    sharedPrefs.changeInt(currTimerIndexKey, _timerIndex);

    sharedPrefs.changeInt(currTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  Timer timerActive()  {
    return Timer.periodic(const Duration(milliseconds: 40), (timer) {
      _milliseconds += 40;
      setSharedPrefs();
      updateMessageStatus();
      notifyListeners();
    });
  }

  void startTimer() {
    _reset = false;
    _active = true;

    setSharedPrefs();
    notificationSound(timerStartedAudio);
    notifyListeners();
    _stopwatch = timerActive();
  }

  void pauseTimer() {
    _reset = false;
    _active = false;
    _resumed = true;

    setSharedPrefs();
    notificationSound(timerPausedAudio);
    notifyListeners();
    _stopwatch.cancel();
  }

  void continueTimer() {
    _reset = false;
    _active = true;

    setSharedPrefs();
    notificationSound(timerResumedAudio);
    notifyListeners();
    _stopwatch = timerActive() as Timer;
  }

  void resetTimer() {
    _milliseconds = 0;
    _timerIndex = 0;
    _reset = true;
    _active = false;
    _resumed = false;

    setSharedPrefs();
    notificationSound(timerStoppedAudio);
    notifyListeners();
  }



  void notificationSound(String audioString) {
    Vibration.vibrate(pattern: [0, 200, 200, 200, 200, 200]);
    FlutterRingtonePlayer.play(fromAsset: audioString);
  }

  void updateMessageStatus() {
    if (_timerIndex < timerLocations2.length) {
      num nextCheckpoint = (timerLocations2[_timerIndex] +
          timerGaps2[_timerIndex]) * 1000;

      if (_milliseconds >= nextCheckpoint) {
        _timerIndex += 1;
        notificationSound(timerActiveAudio2[_timerIndex - 1]);
        notifyListeners();
      }
    }
  }

  String fetchMessage() {
    if (_timerIndex == 0) {
      if (buttonsStart) {
        return timerStoppedMessage;
      }
      if (buttonsPause) {
        return _resumed ? timerResumedMessage : timerStartedMessage;
      }
      return timerPausedMessage;
    }
    return timerActiveMessages2[_timerIndex - 1];
  }

  double fetchProgressBarPosition() {
    if (_timerIndex == timerLocations2.length) {
      return 1;
    }

    num end = timerGaps2[_timerIndex] * 1000;
    num currPos = _milliseconds - timerLocations2[_timerIndex] * 1000;

    return currPos / end;
  }

}