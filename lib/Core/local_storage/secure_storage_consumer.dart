import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pro_icon/Core/errors/exceptions.dart';

import 'local_storage_provider.dart';

class SecureStorageConsumer implements BaseLocalService {
  final FlutterSecureStorage? _secureStorage;

  SecureStorageConsumer({required FlutterSecureStorage secureStorage})
      : _secureStorage = secureStorage;

  @override
  Future<void> put(String key, String value) async {
    try {
      if (kIsWeb) {
        // Fallback to localStorage on the web
        html.window.localStorage[key] = value;
      } else {
        // Use secure storage on other platforms
        await _secureStorage?.write(key: key, value: value);
      }
    } catch (e) {
      throw CacheException('Something went wrong saving data: $e');
    }
  }

  @override
  Future<String?> get(String key) async {
    try {
      if (kIsWeb) {
        // Fallback to localStorage on the web
        return html.window.localStorage[key];
      } else {
        // Use secure storage on other platforms
        return await _secureStorage?.read(key: key);
      }
    } catch (e) {
      throw CacheException('Something went wrong getting data: $e');
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      if (kIsWeb) {
        // Fallback to localStorage on the web
        html.window.localStorage.remove(key);
      } else {
        // Use secure storage on other platforms
        await _secureStorage?.delete(key: key);
      }
    } catch (e) {
      throw CacheException('Something went wrong deleting data: $e');
    }
  }
}
