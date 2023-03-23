import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {

  late SharedPreferences _sharedPrefs;

  init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  initBool(key, defaultBool) {
    return _sharedPrefs.containsKey(key) ? _sharedPrefs.getBool(key)! : defaultBool;
  }

  initInt(key, defaultInt) {
    return _sharedPrefs.containsKey(key) ? _sharedPrefs.getInt(key)! : defaultInt;
  }

  changeBool(key, value) {
    _sharedPrefs.setBool(key, value);
  }

  changeInt(key, value) {
    _sharedPrefs.setInt(key, value);
  }
}

final sharedPrefs = SharedPrefs();