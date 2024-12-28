import 'package:dartz/dartz.dart';
import 'package:pro_icon/Core/entities/user_entity.dart';
import 'package:pro_icon/Core/errors/failures.dart';
import 'package:pro_icon/Core/networking/api_constants.dart';
import 'package:pro_icon/data/mappers/app_user_mapper.dart';
import 'package:pro_icon/data/models/app_user_model.dart';
import 'package:pro_icon/data/models/sign_up_request.dart';

import '../../Core/networking/base_api_provider.dart';
import '../../Core/utils/enums/filteration_type.dart';

class TrainerService {
  final BaseApiProvider _apiProvider;

  TrainerService({required BaseApiProvider apiProvider})
      : _apiProvider = apiProvider;

  Future<Either<Failure, List<UserEntity>>> getTrainers({int? page}) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
      endpoint: ApiConstants.getTrainersEndpoint,
      queryParameters: {'page': page ?? 1},
    );

    if (response.isSuccess) {
      final trainers = (response.data!["trainers"] as List)
          .map((e) => AppUserEntityMapper.toEntity(
              AppUserModel.fromJson(e as Map<String, dynamic>)))
          .toList();
      return Right(trainers);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, List<UserEntity>>> searchTrainerByNameOrEmail(
      {required String query}) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
      endpoint: ApiConstants.getTrainersEndpoint,
      queryParameters: {'searchKey': query},
    );

    if (response.isSuccess) {
      final trainers = (response.data!["trainers"] as List)
          .map((e) => AppUserEntityMapper.toEntity(
              AppUserModel.fromJson(e as Map<String, dynamic>)))
          .toList();
      return Right(trainers);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, List<UserEntity>>> filterTrainers(
      {required FilterationType filterBy}) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
        endpoint: ApiConstants.getTrainersEndpoint,
        queryParameters: {'orderBy': filterBy.name});

    if (response.isSuccess) {
      final trainers = (response.data!["trainers"] as List)
          .map((e) => AppUserEntityMapper.toEntity(
              AppUserModel.fromJson(e as Map<String, dynamic>)))
          .toList();
      return Right(trainers);
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
