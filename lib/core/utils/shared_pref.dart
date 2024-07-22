import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static final SharedPreferencesManager _instance = SharedPreferencesManager._internal();
  SharedPreferences? _preferences;

  factory SharedPreferencesManager() {
    return _instance;
  }

  SharedPreferencesManager._internal();

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Save a string
  Future<void> saveString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  // Retrieve a string
  String? getString(String key) {
    return _preferences?.getString(key);
  }

  // Save an int
  Future<void> saveInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  // Retrieve an int
  int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  // Save a bool
  Future<void> saveBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  // Retrieve a bool
  bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  // Save a double
  Future<void> saveDouble(String key, double value) async {
    await _preferences?.setDouble(key, value);
  }

  // Retrieve a double
  double? getDouble(String key) {
    return _preferences?.getDouble(key);
  }

  // Save a list of strings
  Future<void> saveStringList(String key, List<String> value) async {
    await _preferences?.setStringList(key, value);
  }

  // Retrieve a list of strings
  List<String>? getStringList(String key) {
    return _preferences?.getStringList(key);
  }

  // Remove a specific key
  Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  // Clear all keys
  Future<void> clear() async {
    await _preferences?.clear();
  }
}
