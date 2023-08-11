import 'package:shared_preferences/shared_preferences.dart';

class BookPRef {

  SharedPreferences? _prefs;

  Future<void> setPosition(
    String path,
    double offset,
  ) async {
    print("SAQLASH: ${offset}");
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setDouble(path, offset);
  }

  Future<double> getPosition(String path) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getDouble(path) ?? 0;
  }

  Future<void> setMode(bool mode) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setBool('mode', mode);
  }

  Future<bool> getMode() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getBool('mode') ?? false;
  }

}
