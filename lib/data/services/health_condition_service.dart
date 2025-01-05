import 'package:dartz/dartz.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/models/health_condition_response.dart';

import '../../Core/errors/failures.dart';
import '../../Core/networking/api_constants.dart';

class HealthConditionService {
  final BaseApiProvider _apiProvider;

  HealthConditionService({required BaseApiProvider apiProvider})
      : _apiProvider = apiProvider;

  Future<Either<Failure, HealthConditionResponse>>
      getAllHealthConditions() async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
        endpoint: ApiConstants.lookUpHealthConditions);
    if (response.isSuccess) {
      return Right(HealthConditionResponse.fromJson(response.data!));
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, HealthConditionResponse>> getClientHealthConditions(
      {required int clientId}) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
        endpoint: ApiConstants.clientHealthConditionsEndpoint(clientId));
    if (response.isSuccess) {
      return Right(HealthConditionResponse.fromJson(response.data!));
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, String>> updateClientInjuries(
      {required int clientId, required int injuryId}) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
        endpoint: ApiConstants.updateClientInjuryEndpoint(clientId, injuryId));

    if (response.isSuccess) {
      return Right(response.data!["message"]);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, String>> updateClientDisease(
      {required int clientId, required int diseaseId}) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
        endpoint:
            ApiConstants.updateClientDiseaseEndpoint(clientId, diseaseId));

    if (response.isSuccess) {
      return Right(response.data!["message"]);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }
}
