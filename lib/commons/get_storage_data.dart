import 'dart:convert';

import 'package:get_storage/get_storage.dart';

/// <<< To store data in phone storage --------- >>>
class GetStorageData {
  String loginData = "LoginData";
  String isLogin = "isLogin";
  String baseURL = "baseURL";
  String clientName = "clientName";
  String userId = "userId";
  String token = "token";
  String account = "accountdata";
  String inspectorId = "inspectorId";
  String email = "email";
  String password = "password";
  String fcmToken = "fcmToken";
  String userLAT = "userLAT";
  String userLNG = "userLNG";
  String userLoc = "userLocation";
  String inspectorname = "inspectorname";

  /// <<< To save string data --------- >>>
  saveString(String key, value) async {
    final box = GetStorage();
    return box.write(key, value);
  }

  /// <<< To read string data --------- >>>
  readString(String key) {
    final box = GetStorage();
    if (box.hasData(key)) {
      return box.read(key);
    } else {
      return null;
    }
  }

  /// <<< To remove data --------- >>>
  removeData(String key) async {
    final box = GetStorage();
    return box.remove(key);
  }

  /// <<< To clear all data --------- >>>
  clearAlldata() async {
    final box = GetStorage();
    return box.erase();
  }

  /// <<< To Store Key data --------- >>>
  bool containKey(String key) {
    final box = GetStorage();
    return box.hasData(key);
  }

  /// <<< To save Object data --------- >>>
  saveObject(String key, value) {
    final box = GetStorage();
    String allData = jsonEncode(value);
    box.write(key, allData);
  }

  /// <<< To read Object data --------- >>>
  readObject(String key) {
    final box = GetStorage();
    var result = box.read(key);
    return jsonDecode(result);
  }
}
