import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// <<< To store data in phone storage --------- >>>
class SharedPref {
  // For introduction Screen
  String? isWalkThrough = "isWalkThrough";

  // For lock Screen
  String? isLock = "isLock";

  // For home introduction
  String? isHomeFist = "isHomeFist";

  // For Language
  String? isEnLanguage = "isEnLanguage";
  String lastPurchaseTime = "lastPurchaseTime";

  // For deep linking
  String contractIdDeep = "contractIdDeep";

  /// <<< To read object data --------- >>>
  readObject(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(key);
    if (data == null) {
      return null;
    }
    var decode = json.decode(data);
    if (decode != null) {
      return decode;
    } else {
      return json.decode("");
    }
  }

  /// <<< To save object data --------- >>>
  saveObject(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  /// <<< To read String data --------- >>>
  Future<String> readString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  /// <<< To save string data --------- >>>
  saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  /// <<< To read String data --------- >>>
  Future<List> readStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  /// <<< To save string data --------- >>>
  saveList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  /// <<< To read int data --------- >>>
  readInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getInt(key);
  }

  /// <<< To save int data --------- >>>
  saveInt(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  /// <<< To remove data --------- >>>
  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  /// <<< To Store Key data --------- >>>
  Future<bool> containKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }
}
