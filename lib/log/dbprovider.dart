import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:intl/intl.dart';

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

class DB {

  static Database? _database;

  static final events_table = 'events';

  Future<Database> get database async => _database ??= await initDatabase();

  Future<Database> initDatabase() async{
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'record.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $events_table(category TEXT NOT NULL, header TEXT NOT NULL, subHeader TEXT NOT NULL, interval TEXT NOT NULL, date TEXT NOT NULL, time TEXT NOT NULL, primaryKey TEXT PRIMARY KEY)'
    );
    print("CREATED TABLE");
  }

  Future<void> insertEvent(Event event) async {
    var dbClient = await database;

    await dbClient!.insert(events_table, event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print('INSERTED ' + event.toString());
  }

  Future<void> deleteEvent(String primaryKey) async {
    var dbClient = await database;
    await dbClient!.delete(
      'events',
      where: 'primaryKey = ?',
      whereArgs: [primaryKey],
    );
    print('DELETED ' + primaryKey);
  }

  Future<void> deleteAllEvents() async {
    var dbClient = await database;
    await dbClient!.delete('events');
    print('DELETED ALL');
  }

  Future<List<Event>> getEventList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult = await dbClient!.query(events_table);
    return queryResult.map((result) => Event.fromMap(result)).toList();
  }
}

class DBProvider with ChangeNotifier {

  DB db = DB();
  List<Event> events = [];
  int _badgeCount = 0;
  int get badgeCount => _badgeCount;

  // timeline functions

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
    _setPrefsItems();
    notifyListeners();
  }

  void removeAllEvents() async {
    await db.deleteAllEvents();
    events = [];
    _setPrefsItems();
    notifyListeners();
  }

  // boilerplate SharedPreferences functions

  void _setPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('badgeCount', _badgeCount);
  }

  void _getPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _badgeCount = prefs.getInt('badgeCount') ?? 0;
  }

  // badge count functions

  void incrementBadgeCount() async {
    _badgeCount++;
    _setPrefsItems();
    notifyListeners();
  }

  void decrementBadgeCount() async {
    _badgeCount--;
    _setPrefsItems();
    notifyListeners();
  }

  void resetBadgeCount() async {
    _badgeCount = 0;
    _setPrefsItems();
    notifyListeners();
  }

  int getBadgeCount() {
    _getPrefsItems();
    return _badgeCount;
  }
}