import 'package:pro_icon/Core/local_storage/local_storage_provider.dart';

import '../../Core/constants/app_constants.dart';
import '../../Core/errors/exceptions.dart';

class AuthTokenService {
  final BaseLocalService _localService;

  AuthTokenService({required BaseLocalService localService})
      : _localService = localService;

  Future<String?> getToken() async {
    try {
      final token = await _localService.get(AppConstants.tokenLocalKey);

      return token;
    } on CacheException catch (_) {
      rethrow;
    }
  }

  Future<void> saveToken(String token) async {
    try {
      await _localService.put(AppConstants.tokenLocalKey, token);
    } on CacheException catch (_) {
      rethrow;
    }
  }

  Future<void> deleteToken() async {
    try {
      await _localService.delete(AppConstants.tokenLocalKey);
    } on CacheException catch (_) {
      rethrow;
    }
  }
}
