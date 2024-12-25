import 'package:dio/dio.dart';
import 'package:pro_icon/Core/entities/user_entity.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/mappers/app_user_mapper.dart';
import 'package:pro_icon/data/models/api_response.dart';
import 'package:pro_icon/data/models/app_user_model.dart';

import '../../Core/networking/api_constants.dart';

class UserService {
  final BaseApiProvider _apiProvider;

  UserService({
    required BaseApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  Future<ApiResponse<UserEntity>> getUserByToken(
      {required String token}) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
      endpoint: ApiConstants.currentUserEndpoint,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    if (response.isSuccess) {
      return ApiResponse.success(
          AppUserEntityMapper.toEntity(AppUserModel.fromJson(response.data!)));
    } else {
      return ApiResponse.failure(response.error);
    }
  }
}
