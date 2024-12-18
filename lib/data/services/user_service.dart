import 'package:dio/dio.dart';
import 'package:pro_icon/Core/local_storage/local_storage_provider.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/models/api_response.dart';
import 'package:pro_icon/data/models/app_user_model.dart';

import '../../Core/constants/app_constants.dart';
import '../../Core/errors/exceptions.dart';
import '../../Core/networking/api_constants.dart';

class UserService {
  final BaseApiProvider _apiProvider;
  final BaseLocalService _localService;

  UserService(
      {required BaseApiProvider apiProvider,
      required BaseLocalService localService})
      : _apiProvider = apiProvider,
        _localService = localService;

  Future<ApiResponse<AppUserModel>> getUserByToken(
      {required String token}) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
      endpoint: ApiConstants.currentUserEndpoint,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    if (response.isSuccess) {
      return ApiResponse.success(AppUserModel.fromJson(response.data!));
    } else {
      return ApiResponse.failure(response.error);
    }
  }

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
}
