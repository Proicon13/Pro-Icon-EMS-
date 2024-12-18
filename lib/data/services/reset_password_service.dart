import 'package:pro_icon/Core/networking/base_api_provider.dart';

import '../models/api_response.dart';
import '../models/reset_password_request.dart';

class ResetPasswordService {
  final BaseApiProvider _apiProvider;

  ResetPasswordService({required BaseApiProvider apiProvider})
      : _apiProvider = apiProvider;

  Future<ApiResponse<String>> forgotPassword({required String email}) async {
    final response = await _apiProvider.post<Map<String, dynamic>>(
        endpoint: '/auth/forgot-password', data: {'email': email});
    if (response.isSuccess) {
      return ApiResponse.success(response.data!['message']);
    } else {
      return ApiResponse.failure(response.error);
    }
  }

  Future<ApiResponse<String>> resetPassword(
      {required ResetPasswordRequest resetPasswordRequest}) async {
    final response = await _apiProvider.post<Map<String, dynamic>>(
        endpoint: '/auth/reset-password', data: resetPasswordRequest.toJson());
    if (response.isSuccess) {
      return ApiResponse.success(response.data!['message']);
    } else {
      return ApiResponse.failure(response.error);
    }
  }
}
