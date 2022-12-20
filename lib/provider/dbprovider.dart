import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kybele_gen2/database/db.dart';
import 'package:kybele_gen2/models/event.dart';

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

  void removeEvent(String time) {
    final index = events.indexWhere((elt) => elt.time == time);
    events.removeAt(index);
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