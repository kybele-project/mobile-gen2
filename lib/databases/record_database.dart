import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/event.dart';

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
        """
        CREATE TABLE $eventsTable(
            category TEXT NOT NULL,
            header TEXT NOT NULL,
            subHeader TEXT NOT NULL,
            interval TEXT NOT NULL,
            date TEXT NOT NULL,
            time TEXT NOT NULL,
            primaryKey TEXT PRIMARY KEY
        )
        """
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