import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SessionManagement{
  SessionManagement._internalConstructor();

  static final SessionManagement _instance = SessionManagement._internalConstructor();

  factory SessionManagement(){
    return _instance;
  }

  final Future<SharedPreferences> _storage = SharedPreferences.getInstance();

  Future<bool> saveDataOnKey(String key,Map<String,dynamic> data) async {
    SharedPreferences sharedPreferences = await _storage;
    return await sharedPreferences.setString(key, jsonEncode(data));
  }

  Future<String> getDataOnKey(String key) async {
    SharedPreferences sharedPreferences = await _storage;
    var result = sharedPreferences.get(key);
    String rawData = "";
    if(result is String){
      rawData = result;
    }
    return rawData;
  }

  Future<bool> deleteData(String key) async {
    SharedPreferences sharedPreferences = await _storage;
    return await sharedPreferences.remove(key);
  }
}