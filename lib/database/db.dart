import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:kybele_gen2/models/event.dart';

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
      'CREATE TABLE $events_table(type TEXT NOT NULL, description TEXT NOT NULL, info1 TEXT NOT NULL, info2 TEXT NOT NULL, info3 TEXT NOT NULL, info4 TEXT NOT NULL, info5 TEXT NOT NULL, time TEXT PRIMARY KEY)'
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

  Future<void> deleteEvent(int id) async {
    var dbClient = await database;
    await dbClient!.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Event>> getEventList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult = await dbClient!.query(events_table);
    return queryResult.map((result) => Event.fromMap(result)).toList();
  }
}