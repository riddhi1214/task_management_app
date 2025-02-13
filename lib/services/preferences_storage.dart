import 'package:hive/hive.dart';

class PreferencesStorage {
  static const String _boxName = 'preferencesBox';
  static const String _themeKey = 'isDarkMode';

  Future<void> saveTheme(bool isDarkMode) async {
    final box = await Hive.openBox(_boxName);
    await box.put(_themeKey, isDarkMode);
  }

  Future<bool> loadTheme() async {
    final box = await Hive.openBox(_boxName);
    return box.get(_themeKey, defaultValue: false) as bool;
  }
}