import 'package:flutter/material.dart';

import '../databases/record_database.dart';
import '../models/event.dart';

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