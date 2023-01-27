import 'dart:core';
import 'dart:io' as io;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:vibration/vibration.dart';
import 'package:kybele_gen2/log/timer_metadata.dart';


class Event {
  final String category;
  final String header;
  final String subHeader;
  final String interval;
  late final String date;
  late final String time;
  late final String primaryKey;

  Event ({
    required this.category,
    required this.header,
    required this.subHeader,
    required this.interval,
  }) {
    DateTime timeNoFormat = DateTime.now();
    date = DateFormat.yMMMMd('en_US').format(timeNoFormat);
    time = DateFormat.Hm().format(timeNoFormat);
    primaryKey = category + DateFormat('-MM-dd-yy-kk-mm-ss').format(timeNoFormat);
  }

  Event.fromMap(Map<String, dynamic> data) :
        category = data['category'],
        header = data['header'],
        subHeader = data['subHeader'],
        interval = data['interval'],
        date = data['date'],
        time = data['time'],
        primaryKey = data['primaryKey'];

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'header': header,
      'subHeader': subHeader,
      'interval': interval,
      'date': date,
      'time': time,
      'primaryKey': primaryKey,
    };
  }

  @override
  String toString() {
    return 'Event{primaryKey: $primaryKey, header: $header, subHeader: $subHeader}';
  }
}


class RecordDatabase {

  static Database? _recordDatabase;
  static const eventsTable = 'events';

  Future<Database> get database async => _recordDatabase ??= await initDatabase();

  Future<Database> initDatabase() async{
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'record.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $eventsTable(category TEXT NOT NULL, header TEXT NOT NULL, subHeader TEXT NOT NULL, interval TEXT NOT NULL, date TEXT NOT NULL, time TEXT NOT NULL, primaryKey TEXT PRIMARY KEY)'
    );
  }

  Future<void> insertEvent(Event event) async {
    var dbClient = await database;

    await dbClient.insert(eventsTable, event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteEvent(String primaryKey) async {
    var dbClient = await database;
    await dbClient.delete(
      'events',
      where: 'primaryKey = ?',
      whereArgs: [primaryKey],
    );
  }

  Future<void> deleteAllEvents() async {
    var dbClient = await database;
    await dbClient.delete('events');
  }

  Future<List<Event>> getEventList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult = await dbClient.query(eventsTable);
    return queryResult.map((result) => Event.fromMap(result)).toList();
  }
}

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

class RecordProvider with ChangeNotifier {

  RecordDatabase db = RecordDatabase();
  List<Event> events = [];

  Future<List<Event>> getEvents() async {
    events = await db.getEventList();
    notifyListeners();
    return events;
  }

  void addEvent(Event event) async {
    await db.insertEvent(event);
    events = await getEvents();
  }

  void removeEvent(String primaryKey) async {
    await db.deleteEvent(primaryKey);
    final index = events.indexWhere((elt) => elt.primaryKey == primaryKey);
    events.removeAt(index);
    notifyListeners();
  }

  void removeAllEvents() async {
    await db.deleteAllEvents();
    events = [];
    notifyListeners();
  }
}