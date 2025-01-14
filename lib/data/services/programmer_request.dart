
  import 'package:dartz/dartz.dart';
import 'package:pro_icon/Core/errors/failures.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/models/programming_request.dart';

class ProgrammerRequestService {

  final BaseApiProvider baseApiProvider;

  ProgrammerRequestService({required this.baseApiProvider});

  Future<Either<Failure , ProgrammingRequest>> getProgrammingRequest () async
  {
    final response = await baseApiProvider.get<Map<String , dynamic>>(endpoint: '/programer');

    if(response.isSuccess)
    {
      return Right(
      ProgrammingRequest.fromJson(response.data!)
      );
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }

  }


  }