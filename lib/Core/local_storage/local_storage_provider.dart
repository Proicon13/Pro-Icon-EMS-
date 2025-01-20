abstract class BaseLocalService {
  /// Save a value with the given key
  Future<void> put<T>(String key, T value);

  /// Retrieve a value by its key
  Future<T?> get<T>(String key);

  /// Delete a value by its key
  Future<void> delete<T>(String key);
}

abstract class ExtendedLocalService extends BaseLocalService {
  /// Add a value with an auto-increment key or custom key (if the box supports unique keys).
  Future<void> add<T>(String boxName, T value);

  /// Replace a value at a specific index or key (keys act as indexes in Hive).
  Future<void> putAt<T>(String boxName, int index, T value);
  Future<List<T>> getList<T>(String key);
}
