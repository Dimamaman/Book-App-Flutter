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

  static final BookPRef _instance = BookPRef._internal();

  factory BookPRef() {
    return _instance;
  }

  BookPRef._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool getBool() {
    return _prefs?.getBool('isFirst') ?? true;
  }

  Future<void> setBool(bool value) async {
    await _prefs?.setBool('isFirst', value);
  }
}
