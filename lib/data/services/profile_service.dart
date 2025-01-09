import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pro_icon/Core/entities/user_entity.dart';

import '../../Core/errors/failures.dart';
import '../../Core/networking/api_constants.dart';
import '../../Core/networking/base_api_provider.dart';
import '../mappers/app_user_mapper.dart';
import '../models/app_user_model.dart';

class ProfileService {
  final BaseApiProvider _apiProvider;

  ProfileService({required BaseApiProvider apiProvider})
      : _apiProvider = apiProvider;

  Future<Either<Failure, UserEntity>> updateProfile(
      {required Map<String, dynamic> body}) async {
    late FormData data;

    // Check if the body contains a file
    if (body.containsKey("file")) {
      // Extract the file path and create a MultipartFile
      final file = await MultipartFile.fromFile(
        body["file"],
        filename: body["file"].split('/').last,
      );

      // Create FormData with the file and the rest of the body
      final Map<String, dynamic> formDataMap = Map.from(body);
      formDataMap["file"] = file;
      data = FormData.fromMap(formDataMap);
    } else {
      // Create FormData from the body map if no file is present
      data = FormData.fromMap(body);
    }

    final response = await _apiProvider.putMultipart<Map<String, dynamic>>(
        endpoint: ApiConstants.usersEndpoint,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ));

    if (response.isSuccess) {
      final user =
          AppUserEntityMapper.toEntity(AppUserModel.fromJson(response.data!));

      return Right(user);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }
}
