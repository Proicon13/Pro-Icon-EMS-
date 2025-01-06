import 'package:pro_icon/Core/networking/api_constants.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/models/api_response.dart';
import 'package:pro_icon/data/models/login_response_model.dart';

import '../../Core/constants/app_constants.dart';
import '../../Core/errors/exceptions.dart';
import '../../Core/local_storage/local_storage_provider.dart';
import '../models/app_user_model.dart';
import '../models/login_request_.dart';
import '../models/sign_up_request.dart';

class AuthService {
  final BaseApiProvider _apiProvider;
  final BaseLocalService _localService;
  AuthService(
      {required BaseApiProvider apiProvider,
      required BaseLocalService localService})
      : _localService = localService,
        _apiProvider = apiProvider;
  Future<void> logout() async {
    try {
      await _localService.delete(AppConstants.tokenLocalKey);
    } on CacheException catch (_) {
      rethrow;
    }
  }

  Future<ApiResponse<LoginResponseModel>> login(
      {required LoginRequest loginRequest}) async {
    final response = await _apiProvider.post<Map<String, dynamic>>(
      endpoint: ApiConstants.loginEndPoint,
      data: loginRequest.toJson(),
    );
    if (response.isSuccess) {
      return ApiResponse.success(LoginResponseModel.fromJson(response.data!));
    } else {
      return ApiResponse.failure(response.error);
    }
  }

  Future<ApiResponse<AppUserModel>> register(
      {required SignupRequest signUpRequest}) async {
    final response = await _apiProvider.post<Map<String, dynamic>>(
      endpoint: ApiConstants.registerEndpoint,
      data: signUpRequest.toJson(),
    );

    if (response.isSuccess) {
      return ApiResponse.success(AppUserModel.fromJson(response.data!));
    } else {
      return ApiResponse.failure(response.error);
    }
  }
}
