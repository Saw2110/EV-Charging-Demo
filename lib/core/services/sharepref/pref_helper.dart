import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core.dart';

class SharedPref {
  Future<dynamic> get({
    required String key,
    PrefType type = PrefType.string,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (type) {
      case PrefType.string:
        return prefs.getString(key) ?? "";
      case PrefType.int:
        return prefs.getInt(key) ?? 0;
      case PrefType.bool:
        return prefs.getBool(key) ?? false;
      case PrefType.double:
        return prefs.getDouble(key) ?? 0.0;
      default:
        final String jsonString = prefs.getString(key) ?? "";
        return jsonString.isNotEmpty ? json.decode(jsonString) : null;
    }
  }

  Future<void> set({
    required String key,
    required dynamic value,
    PrefType type = PrefType.string,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (type) {
      case PrefType.string:
        await prefs.setString(key, value.toString());
      case PrefType.int:
        await prefs.setInt(key, value);
      case PrefType.bool:
        await prefs.setBool(key, value);
      case PrefType.double:
        await prefs.setDouble(key, value);
      default:
        final String jsonString = json.encode(value);
        await prefs.setString(key, jsonString);
    }
  }

  Future<void> remove({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> removeAllData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
