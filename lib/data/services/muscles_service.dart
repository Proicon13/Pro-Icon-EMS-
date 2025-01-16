import 'package:dartz/dartz.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';

import '../../Core/errors/failures.dart';
import '../../Core/networking/api_constants.dart';
import '../models/muscle.dart';

class MusclesService {
  final BaseApiProvider _baseApiProvider;

  MusclesService({required BaseApiProvider baseApiProvider})
      : _baseApiProvider = baseApiProvider;

  Future<Either<Failure, List<Muscle>>> getMuscles() async {
    final response = await _baseApiProvider.get<List<dynamic>>(
        endpoint: ApiConstants.lookupMusclesEndpoint);

    if (response.isSuccess) {
      return Right(response.data!.map((e) => Muscle.fromJson(e)).toList());
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }
}
