import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    @required String key,
    @required value,
  }) {
    if (value is bool) return sharedPreferences.setBool(key, value);
    if (value is double) return sharedPreferences.setDouble(key, value);
    if (value is int) return sharedPreferences.setInt(key, value);
    if (value is String) return sharedPreferences.setString(key, value);
  }

  static Object getData(String key) {
    return sharedPreferences.get(key);
  }
}
