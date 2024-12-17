import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/models/login_response_model.dart';

import '../../Core/errors/exceptions.dart';
import '../models/app_user_model.dart';
import '../models/login_request_.dart';
import '../models/sign_up_request.dart';

class AuthService {
  final BaseApiProvider _apiProvider;
  AuthService({required BaseApiProvider apiProvider})
      : _apiProvider = apiProvider;
  Future<void> logout() async {}
  Future<LoginResponseModel> login({required LoginRequest loginRequest}) async {
    try {
      final response = await _apiProvider.post<Map<String, dynamic>>(
        endpoint: '/auth/login',
        data: loginRequest.toJson(),
      );

      return LoginResponseModel.fromJson(response.data!);
    } on ServerException catch (_) {
      rethrow;
    }
  }

  Future<AppUserModel> register({required SignupRequest signUpRequest}) async {
    try {
      final response = await _apiProvider.post<Map<String, dynamic>>(
        endpoint: '/auth/register',
        data: signUpRequest.toJson(),
      );

      return AppUserModel.fromJson(response.data!);
    } on ServerException catch (_) {
      rethrow;
    }
  }
}
