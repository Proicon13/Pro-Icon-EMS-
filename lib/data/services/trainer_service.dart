import 'package:dartz/dartz.dart';
import 'package:pro_icon/Core/errors/failures.dart';
import 'package:pro_icon/Core/networking/api_constants.dart';
import 'package:pro_icon/data/models/app_user_model.dart';

import '../../Core/networking/base_api_provider.dart';
import '../../Core/utils/enums/filteration_type.dart';

class TrainerService {
  final BaseApiProvider _apiProvider;

  TrainerService({required BaseApiProvider apiProvider})
      : _apiProvider = apiProvider;

  Future<Either<Failure, List<AppUserModel>>> getTrainers({int? page}) async {
    final response = await _apiProvider.get<List<dynamic>>(
      endpoint: ApiConstants.getTrainersEndpoint,
      queryParameters: {'page': page ?? 1},
    );

    if (response.isSuccess) {
      final trainers =
          response.data!.map((e) => AppUserModel.fromJson(e)).toList();
      return Right(trainers);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, List<AppUserModel>>> searchTrainerByNameOrEmail(
      {required String query}) async {
    final response = await _apiProvider.get<List<dynamic>>(
      endpoint: ApiConstants.getTrainersEndpoint,
      queryParameters: {'searchKey': query},
    );

    if (response.isSuccess) {
      final trainers =
          response.data!.map((e) => AppUserModel.fromJson(e)).toList();
      return Right(trainers);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, List<AppUserModel>>> filterTrainers(
      {required FilterationType filterBy}) async {
    final response = await _apiProvider.get<List<dynamic>>(
        endpoint: ApiConstants.getTrainersEndpoint,
        queryParameters: {'orderBy': filterBy.name});

    if (response.isSuccess) {
      final trainers =
          response.data!.map((e) => AppUserModel.fromJson(e)).toList();
      return Right(trainers);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }
}
