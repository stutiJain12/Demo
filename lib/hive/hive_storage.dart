import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  // Generic Method to put data
  static Future<void> putData(String boxName, String key, dynamic value) async {
    final box = await Hive.openBox(boxName);
    await box.put(key, value);
  }

  // Generic Method to get data
  static Future<dynamic> getData(String boxName, String key, {dynamic defaultValue}) async {
    final box = await Hive.openBox(boxName);
    return box.get(key, defaultValue: defaultValue);
  }

  // Generic Method to delete data
  static Future<void> deleteData(String boxName, String key) async {
    final box = await Hive.openBox(boxName);
    await box.delete(key);
  }
}
