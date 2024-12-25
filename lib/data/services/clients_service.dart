import 'package:dartz/dartz.dart';
import 'package:pro_icon/Core/entities/user_entity.dart';
import 'package:pro_icon/Core/errors/failures.dart';
import 'package:pro_icon/Core/networking/api_constants.dart';
import 'package:pro_icon/data/mappers/client_entity_mapper.dart';
import 'package:pro_icon/data/models/api_response.dart';
import 'package:pro_icon/data/models/client_model.dart';

import '../../Core/networking/base_api_provider.dart';
import '../../Core/utils/enums/filteration_type.dart';

class ClientsService {
  final BaseApiProvider _apiProvider;

  ClientsService({required BaseApiProvider apiProvider})
      : _apiProvider = apiProvider;

  Future<Either<Failure, List<UserEntity>>> getClients({int? page}) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
      endpoint: ApiConstants.clientsEndPoint,
      queryParameters: {'page': page ?? 1},
    );

    if (response.isSuccess) {
      return _handleSuccessClientListResponse(response);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, List<UserEntity>>> searchTrainerByNameOrEmail(
      {required String query}) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
      endpoint: ApiConstants.clientsEndPoint,
      queryParameters: {'searchKey': query},
    );

    if (response.isSuccess) {
      return _handleSuccessClientListResponse(response);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, List<UserEntity>>> filterTrainers(
      {required FilterationType filterBy}) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
        endpoint: ApiConstants.clientsEndPoint,
        queryParameters: {'orderBy': filterBy.name});

    if (response.isSuccess) {
      return _handleSuccessClientListResponse(response);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Right<Failure, List<UserEntity>> _handleSuccessClientListResponse(
      ApiResponse<Map<String, dynamic>> response) {
    final clients = (response.data!["clients"] as List)
        .map((e) => ClientEntityMapper.fromModel(
            ClientModel.fromJson(e as Map<String, dynamic>)))
        .toList();
    return Right(clients);
  }
}
