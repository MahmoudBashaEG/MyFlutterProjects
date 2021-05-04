import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences sharedPreferences;

  static Future<void> init() async {
    return sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    @required String key,
    @required value,
  }) async {
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is double) return await sharedPreferences.setDouble(key, value);
    if (value is int)
      return await sharedPreferences.setInt(key, value);
    else
      return await sharedPreferences.setString(key, value);
  }

  static Object getData(String key) {
    return sharedPreferences.get(key);
  }

  static Future<bool> deleteData({@required String key}) {
    return sharedPreferences.remove(key);
  }

  static Future<bool> deleteAllData() {
    return sharedPreferences.clear();
  }
}
