import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/models/api_response.dart';
import 'package:pro_icon/data/models/login_response_model.dart';

import '../models/app_user_model.dart';
import '../models/login_request_.dart';
import '../models/sign_up_request.dart';

class AuthService {
  final BaseApiProvider _apiProvider;
  AuthService({required BaseApiProvider apiProvider})
      : _apiProvider = apiProvider;
  Future<void> logout() async {}
  Future<ApiResponse<LoginResponseModel>> login(
      {required LoginRequest loginRequest}) async {
    final response = await _apiProvider.post<Map<String, dynamic>>(
      endpoint: '/auth/login',
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
      endpoint: '/auth/register',
      data: signUpRequest.toJson(),
    );

    if (response.isSuccess) {
      return ApiResponse.success(AppUserModel.fromJson(response.data!));
    } else {
      return ApiResponse.failure(response.error);
    }
  }
}
