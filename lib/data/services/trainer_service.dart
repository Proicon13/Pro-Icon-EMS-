import 'package:dartz/dartz.dart';
import 'package:pro_icon/Core/entities/user_entity.dart';
import 'package:pro_icon/Core/errors/failures.dart';
import 'package:pro_icon/Core/networking/api_constants.dart';
import 'package:pro_icon/data/mappers/app_user_mapper.dart';
import 'package:pro_icon/data/models/app_user_model.dart';
import 'package:pro_icon/data/models/sign_up_request.dart';

import '../../Core/networking/base_api_provider.dart';
import '../../Core/utils/enums/filteration_type.dart';
import '../models/pagination_response.dart';

class TrainerService {
  final BaseApiProvider _apiProvider;

  TrainerService({required BaseApiProvider apiProvider})
      : _apiProvider = apiProvider;

  Future<Either<Failure, PaginationResponse<UserEntity, AppUserModel>>>
      getTrainers({int? page}) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
      endpoint: ApiConstants.getTrainersEndpoint,
      queryParameters: {'page': page ?? 1},
    );

    if (response.isSuccess) {
      final paginatedResponse =
          PaginationResponse<UserEntity, AppUserModel>.fromDataResponse(
        fromJsonT: AppUserModel.fromJson, //response model
        json: response.data!,
        keyName: "trainers",
        mapper: AppUserEntityMapper.toEntity, // entity mapper
      );
      return Right(paginatedResponse);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, PaginationResponse<UserEntity, AppUserModel>>>
      searchTrainerByNameOrEmail({required String query}) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
      endpoint: ApiConstants.getTrainersEndpoint,
      queryParameters: {'searchKey': query},
    );

    if (response.isSuccess) {
      final paginatedResponse =
          PaginationResponse<UserEntity, AppUserModel>.fromDataResponse(
        fromJsonT: AppUserModel.fromJson, //response model
        json: response.data!,
        keyName: "trainers",
        mapper: AppUserEntityMapper.toEntity, // entity mapper
      );
      return Right(paginatedResponse);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, PaginationResponse<UserEntity, AppUserModel>>>
      filterTrainers({required FilterationType filterBy, int? page}) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
        endpoint: ApiConstants.getTrainersEndpoint,
        queryParameters: {
          'orderBy': filterBy.name,
          'perPage': page != null
              ? (page * ApiConstants.defaultPerPage).toString()
              : ApiConstants.defaultPerPage.toString()
        });

    if (response.isSuccess) {
      final paginatedResponse =
          PaginationResponse<UserEntity, AppUserModel>.fromDataResponse(
        fromJsonT: AppUserModel.fromJson, //response model
        json: response.data!,
        keyName: "trainers",
        mapper: AppUserEntityMapper.toEntity, // entity mapper
      );
      return Right(paginatedResponse);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, UserEntity>> updateTrainerDetails(
      {required int id, required Map<String, dynamic> body}) async {
    final response = await _apiProvider.put<Map<String, dynamic>>(
      endpoint: "${ApiConstants.getTrainersEndpoint}/$id",
      data: body,
    );

    if (response.isSuccess) {
      final trainer =
          AppUserEntityMapper.toEntity(AppUserModel.fromJson(response.data!));
      return Right(trainer);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, String>> deleteTrainer({required int id}) async {
    final response = await _apiProvider.delete<Map<String, dynamic>>(
      endpoint: "${ApiConstants.getTrainersEndpoint}/$id",
    );

    if (response.isSuccess) {
      return Right(response.data!["message"]);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, UserEntity>> addTrainerByAdmin(
      {required SignupRequest body}) async {
    final response = await _apiProvider.post<Map<String, dynamic>>(
      endpoint: ApiConstants.addTrainerEndpoint,
      data: body.toJson(),
    );

    if (response.isSuccess) {
      final trainer =
          AppUserEntityMapper.toEntity(AppUserModel.fromJson(response.data!));
      return Right(trainer);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }
}
