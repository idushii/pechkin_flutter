import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static late SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static setToken(String token) {
    prefs.setString('token', token);
  }

  static String getToken() {
    return prefs.getString('token') ?? "";
  }

  static clear() {
    prefs.clear();
  }

  static setJson(String key, Map<String, dynamic> json) {
    prefs.setString(key, jsonEncode(json));
  }

  static Map<String, dynamic> getJson(String key) {
    return jsonDecode(prefs.getString(key) ?? "{}");
  }

  // getStringList

  static setStringList(String key, List<String> list) {
    prefs.setStringList(key, list);
  }

  static List<String> getStringList(String key) {
    return prefs.getStringList(key) ?? [];
  }

  //getString

  static setString(String key, String value) {
    prefs.setString(key, value);
  }

  static String getString(String key) {
    return prefs.getString(key) ?? "";
  }
}