import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

import '../../domain/preferences/repository/preferences_repository.dart';

@LazySingleton(as: PreferencesRepository)
class PreferencesRepositoryImpl implements PreferencesRepository {
  @override
  Future<void> set(String key, value) async {
    final prefs = await _getSharedPreferences();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    }
  }

  @override
  Future<dynamic> get(String key) async {
    return (await _getSharedPreferences()).get(key);
  }

  @override
  Future<void> remove(String key) async {
    (await _getSharedPreferences()).remove(key);
  }

  Future<SharedPreferences> _getSharedPreferences() async =>
      await SharedPreferences.getInstance();
}
