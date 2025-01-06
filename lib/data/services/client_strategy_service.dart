import 'package:dartz/dartz.dart';
import 'package:pro_icon/Core/errors/failures.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/models/client_strategy.dart';

import '../../Core/networking/api_constants.dart';

class ClientStrategyService {
  final BaseApiProvider _baseApiProvider;

  ClientStrategyService({required BaseApiProvider baseApiProvider})
      : _baseApiProvider = baseApiProvider;

  Future<Either<Failure, ClientStrategy>> getClientStrategy(
      {required int clientId}) async {
    final response = await _baseApiProvider.get<Map<String, dynamic>>(
        endpoint: ApiConstants.clientStrategyEndpoint(clientId));
    if (response.isSuccess) {
      return Right(ClientStrategy.fromJson(response.data!));
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, ClientStrategy>> updateClientStrategy(
      {required int clientId, required Map<String, dynamic> body}) async {
    final response = await _baseApiProvider.put<Map<String, dynamic>>(
        endpoint: ApiConstants.clientStrategyEndpoint(clientId), data: body);
    if (response.isSuccess) {
      return Right(ClientStrategy.fromJson(response.data!));
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }
}
