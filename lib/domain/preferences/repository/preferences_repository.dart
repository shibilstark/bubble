abstract class PreferencesRepository {
  Future<void> set(
    String key,
    dynamic value,
  );

  Future<dynamic> get(String key);

  Future<void> remove(String key);
}
