abstract class BaseLocalService {
  /// Save a value with the given key
  Future<void> put(String key, String value);

  /// Retrieve a value by its key
  Future<String?> get(String key);

  /// Delete a value by its key
  Future<void> delete(String key);
}
