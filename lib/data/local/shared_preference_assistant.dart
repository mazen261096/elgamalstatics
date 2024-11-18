import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceAssistant {

  static Future<Map>  fetchSavedShared(String key) async {
    final SharedPreferences prefs =await SharedPreferences.getInstance();
    Map data = json.decode(prefs.getString(key)!)as Map<String,dynamic>;
    return data ;
  }

  static  Future<bool> saveShared(Map<String,dynamic> data,String key ) async {
    final prefs =await SharedPreferences.getInstance();
    final jsonfile = jsonEncode(data);
    return await prefs.setString(key, jsonfile);
  }

  static deleteShared(String key) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<bool>isSharedSaved(String key) async {
    final prefs =await SharedPreferences.getInstance();
    if(!prefs.containsKey(key)){
      return false;
    }else{
      return true ;
    }
  }

  static Future<bool> clearShared() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static Future<String?> getString(String key) async {
    final prefs =await SharedPreferences.getInstance();
    String? value = prefs.getString(key);
    return value ;
  }

  static Future<bool> setString (String key , String value) async {
    final prefs =await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

}