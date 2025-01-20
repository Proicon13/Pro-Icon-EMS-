import 'package:hive/hive.dart';

import '../errors/exceptions.dart';
import 'local_storage_provider.dart';

class HiveConsumer implements ExtendedLocalService {
  /// Ensures the box is open using the key as the box name
  Future<Box> _getBox<T>(String boxKey) async {
    try {
      if (!Hive.isBoxOpen(boxKey)) {
        return await Hive.openBox<T>(boxKey);
      }
      return Hive.box<T>(boxKey);
    } catch (e) {
      throw CacheException("Failed to open or access box: $boxKey");
    }
  }

  @override
  Future<void> put<T>(String key, T value) async {
    try {
      final box = await _getBox<T>(key); // Use the key as the box name
      await box.put(key, value);
    } catch (e) {
      throw CacheException("Failed to save data to box: $key");
    }
  }

  @override
  Future<T?> get<T>(String key) async {
    try {
      final box = await _getBox<T>(key); // Open the box with the key
      final value = box.get(key);

      return value;
    } catch (e) {
      throw CacheException("Failed to retrieve data from box: $key");
    }
  }

  @override
  Future<void> delete<T>(String key) async {
    try {
      final box = await _getBox(key); // Use the key as the box name
      await box.delete(key);
    } catch (e) {
      throw CacheException("Failed to delete data from box: $key");
    }
  }

  @override
  Future<void> add<T>(String boxName, T value) async {
    try {
      final box = await _getBox<T>(boxName);
      final values = box.values.toList();
      if (values.contains(value)) return;

      await box.add(value);
    } catch (e) {
      throw CacheException("Failed to add value to box: $boxName");
    }
  }

  @override
  Future<void> putAt<T>(String boxName, int index, T value) async {
    try {
      final box = await _getBox<T>(boxName);
      await box.putAt(index, value);
    } catch (e) {
      throw CacheException(
          "Failed to replace value at key $index in box: $boxName");
    }
  }

  @override
  Future<List<T>> getList<T>(String key) async {
    try {
      final box = await _getBox<T>(key);

      final result = box.values.cast<T>().toList();

      return result;
    } catch (e) {
      throw CacheException("Failed to retrieve data from box: $key");
    }
  }
}
