import 'package:dartz/dartz.dart';
import 'package:pro_icon/Core/entities/mad_session_entity.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/mappers/mad_session_entity_mapper.dart';
import 'package:pro_icon/data/models/mad_session_model.dart';

import '../../Core/errors/failures.dart';
import '../../Core/networking/api_constants.dart';
import '../models/api_response.dart';
import '../models/pagination_response.dart';

class MadSessionsService {
  final BaseApiProvider _apiProvider;

  MadSessionsService({required BaseApiProvider apiProvider})
      : _apiProvider = apiProvider;

  Future<Either<Failure, PaginationResponse<MadSessionEntity, MadSessionModel>>>
      getMadsSession(
          {required int madId,
          int? page,
          int? perPage,
          String? fromDate,
          String? toDate}) async {
    final response = await _apiProvider.get<Map<String, dynamic>>(
      endpoint: ApiConstants.getMadSessionsEndpoints(madId),
      queryParameters: {
        'page': page ?? 1,
        "from": fromDate,
        "to": toDate,
        "perPage": perPage ?? ApiConstants.defaultPerPage
      },
    );

    if (response.isSuccess) {
      return _handleSuccessResponse(response);
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }

  Right<Failure, PaginationResponse<MadSessionEntity, MadSessionModel>>
      _handleSuccessResponse(ApiResponse<Map<String, dynamic>> response) {
    final sessions =
        PaginationResponse<MadSessionEntity, MadSessionModel>.fromDataResponse(
      fromJsonT: MadSessionModel.fromJson, //response model
      json: response.data!,
      keyName: "sessions",
      mapper: MadSessionEntityMapper.toEntity, // entity mapper
    );
    return Right(sessions);
  }
}
