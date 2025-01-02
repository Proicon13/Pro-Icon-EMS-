import 'package:dartz/dartz.dart';
import 'package:pro_icon/Core/entities/user_entity.dart';
import 'package:pro_icon/Core/errors/failures.dart';
import 'package:pro_icon/Core/networking/api_constants.dart';
import 'package:pro_icon/data/mappers/client_entity_mapper.dart';
import 'package:pro_icon/data/models/api_response.dart';
import 'package:pro_icon/data/models/client_model.dart';
import 'package:pro_icon/data/models/pagination_response.dart';
import 'package:pro_icon/data/models/update_client_response.dart';

import '../../Core/networking/base_api_provider.dart';
import '../../Core/utils/enums/filteration_type.dart';
import '../models/client_details_model.dart';

class ClientsService {
  final BaseApiProvider _apiProvider;

  ClientsService({required BaseApiProvider apiProvider})
      : _apiProvider = apiProvider;

  Future<Either<Failure, UserEntity>> getClientById({required int id}) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
      endpoint: "${ApiConstants.clientsEndPoint}/$id",
    );

    if (response.isSuccess) {
      final client = ClientEntityMapper.fromModel(
          ClientDetailsModel.fromJson(response.data!));
      return Right(client);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, PaginationResponse<UserEntity, ClientModel>>>
      getClients({int? page}) async {
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

  Future<Either<Failure, PaginationResponse<UserEntity, ClientModel>>>
      searchClientByNameOrEmail({required String query}) async {
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

  Future<Either<Failure, UpdateResponseModel>> updateClientDetails(
      {required int id, required Map<String, dynamic> body}) async {
    final response = await _apiProvider.put<Map<String, dynamic>>(
      endpoint: "${ApiConstants.clientsEndPoint}/$id",
      data: body,
    );

    if (response.isSuccess) {
      final client = UpdateResponseModel.fromJson(response.data!);
      return Right(client);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, ClientModel>> addClient(
      {required Map<String, dynamic> body}) async {
    final response = await _apiProvider.post<Map<String, dynamic>>(
      endpoint: ApiConstants.clientsEndPoint,
      data: body,
    );

    if (response.isSuccess) {
      final client = ClientModel.fromJson(response.data!);
      return Right(client);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, PaginationResponse<UserEntity, ClientModel>>>
      filterClients({required FilterationType filterBy, int? page}) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
        endpoint: ApiConstants.clientsEndPoint,
        queryParameters: {
          'orderBy': filterBy.name,
          'perPage': page != null
              ? (page * ApiConstants.defaultPerPage).toString()
              : ApiConstants.defaultPerPage.toString()
        });

    if (response.isSuccess) {
      return _handleSuccessClientListResponse(response);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Right<Failure, PaginationResponse<UserEntity, ClientModel>>
      _handleSuccessClientListResponse(
          ApiResponse<Map<String, dynamic>> response) {
    final clients =
        PaginationResponse<UserEntity, ClientModel>.fromDataResponse(
      fromJsonT: ClientModel.fromJson, //response model
      json: response.data!,
      keyName: "clients",
      mapper: ClientEntityMapper.fromModel, // entity mapper
    );
    return Right(clients);
  }
}
