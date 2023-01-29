import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:vibration/vibration.dart';

import '../databases/timer_metadata.dart';

class TimerProvider with ChangeNotifier {

  late Timer _stopwatch;

  int _milliseconds = 0;
  int get milliseconds => _milliseconds;

  // Timer logic
  String fetchTime() {
    int totalSeconds = (_milliseconds/1000).floor();
    int minutes = (totalSeconds / 60).floor();
    int seconds = totalSeconds % 60;
    return "${timerNumberFormat.format(minutes)}:${timerNumberFormat.format(seconds)}";
  }

  // Button logic
  bool _reset = true;
  bool _active = false;

  bool get buttonsStart => ((_reset == true) && (_active == false));
  bool get buttonsPause => ((_reset == false) && (_active == true));
  bool get buttonsContinueReset => ((_reset = false) && (_active == false));

  Timer timerActive() {
    return Timer.periodic(const Duration(milliseconds: 40), (timer) {
      _milliseconds += 40;
      updateMessageStatus();
      notifyListeners();
    });
  }

  void startTimer() {
    _reset = false;
    _active = true;
    notificationSound(timerStartedAudio);
    notifyListeners();
    _stopwatch = timerActive();
  }

  void pauseTimer() {
    _reset = false;
    _active = false;
    _resumed = true;
    notificationSound(timerPausedAudio);
    notifyListeners();
    _stopwatch.cancel();
  }

  void continueTimer() {
    _reset = false;
    _active = true;
    notificationSound(timerResumedAudio);
    notifyListeners();
    _stopwatch = timerActive();
  }

  void resetTimer() {
    _milliseconds = 0;
    _timerIndex = 0;
    _reset = true;
    _active = false;
    _resumed = false;
    notificationSound(timerStoppedAudio);
    notifyListeners();
  }

  // Notification logic
  int _timerIndex = 0;
  bool _resumed = false;

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