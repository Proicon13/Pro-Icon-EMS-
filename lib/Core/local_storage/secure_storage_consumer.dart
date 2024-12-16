import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pro_icon/Core/errors/exceptions.dart';

import 'local_storage_provider.dart';

class SecureStorageConsumer implements BaseLocalService {
  final FlutterSecureStorage _secureStorage;

  SecureStorageConsumer({required FlutterSecureStorage secureStorage})
      : _secureStorage = secureStorage;

  @override
  Future<void> put(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      throw CacheException('something went wrong saving data');
    }
  }

  @override
  Future<String?> get(String key) async {
    try {
      final value = await _secureStorage.read(key: key);

      return value;
    } catch (e) {
      throw CacheException('something went wrong getting data');
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      throw CacheException('something went wrong deleting data');
    }
  }
}
