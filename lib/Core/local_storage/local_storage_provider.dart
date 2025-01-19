abstract class BaseLocalService {
  /// Save a value with the given key
  Future<void> put<T>(String key, T value);

  /// Retrieve a value by its key
  Future<T?> get<T>(String key);

  /// Delete a value by its key
  Future<void> delete<T>(String key);
}
