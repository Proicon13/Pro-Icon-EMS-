import 'package:hive/hive.dart';

import '../errors/exceptions.dart';
import 'local_storage_provider.dart';

class HiveConsumer implements BaseLocalService {
  /// Ensures the box is open using the key as the box name
  Future<Box> _getBox<T>(String boxKey) async {
    try {
      if (!Hive.isBoxOpen(boxKey)) {
        return await Hive.openBox<T>(boxKey);
      }
      return Hive.box(boxKey);
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
      final box = await _getBox<T>(key); // Use the key as the box name
      return box.get(key) as T?;
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
}
