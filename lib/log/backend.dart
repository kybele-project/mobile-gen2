import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


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