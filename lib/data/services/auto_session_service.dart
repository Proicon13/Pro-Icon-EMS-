import 'package:dartz/dartz.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/mappers/automatic_session_entity_mapper.dart';
import 'package:pro_icon/data/models/auto_session_model.dart';

import '../../Core/entities/automatic_session_entity.dart';
import '../../Core/errors/failures.dart';
import '../../Core/networking/api_constants.dart';
import '../models/api_response.dart';
import '../models/pagination_response.dart';

class AutoSessionService {
  final BaseApiProvider _apiProvider;

  AutoSessionService({required BaseApiProvider apiProvider})
      : _apiProvider = apiProvider;

  Future<
          Either<Failure,
              PaginationResponse<AutomaticSessionEntity, AutoSessionModel>>>
      getAutomaticSessions({
    required String type,
    int? page,
    int? perPage,
  }) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
      endpoint: ApiConstants.automaticSessionEndpoint,
      queryParameters: {
        'page': page ?? 1,
        "type": type,
        "perPage": perPage ?? ApiConstants.defaultPerPage
      },
    );

    if (response.isSuccess) {
      return _handleSuccessResponse(response);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Right<Failure, PaginationResponse<AutomaticSessionEntity, AutoSessionModel>>
      _handleSuccessResponse(ApiResponse<Map<String, dynamic>> response) {
    final sessions = PaginationResponse<AutomaticSessionEntity,
        AutoSessionModel>.fromDataResponse(
      fromJsonT: AutoSessionModel.fromJson, //response model
      json: response.data!,
      keyName: "sessions",
      mapper: AutomaticSessionEntityMapper.fromModel, // entity mapper
    );
    return Right(sessions);
  }

  Future<Either<Failure, AutoSessionModel>> createAutomaticSession({
    required AutoSessionModel data,
  }) async {
    final response = await _apiProvider.post<Map<String, dynamic>>(
      endpoint: ApiConstants.automaticSessionEndpoint,
      data: data.toJson(),
    );

    if (response.isSuccess) {
      return Right(AutoSessionModel.fromJson(response.data!));
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, AutoSessionModel>> updateAutomaticSession(
      {required AutoSessionModel data, required int id}) async {
    final response = await _apiProvider.put<Map<String, dynamic>>(
      endpoint: ApiConstants.automaticSessionUpdateEndpoint(id),
      data: data.toJson(),
    );

    if (response.isSuccess) {
      return Right(AutoSessionModel.fromJson(response.data!));
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Future<Either<Failure, String>> deleteAutomaticSession(
      {required int id}) async {
    final response = await _apiProvider.delete<Map<String, dynamic>>(
      endpoint: ApiConstants.automaticSessionEndpoint,
    );

    if (response.isSuccess) {
      return Right(response.data!["message"]);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }
}
