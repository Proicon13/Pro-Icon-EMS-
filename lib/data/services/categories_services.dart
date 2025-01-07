import 'package:dartz/dartz.dart';
import 'package:pro_icon/Core/errors/failures.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/models/categories_model.dart';

class CategoriesServices {
  final BaseApiProvider baseApiProvider;

  CategoriesServices({required this.baseApiProvider});

  Future<Either<Failure, List<Categories>>> getCategorirs() async {
    final response = await baseApiProvider.get<List<dynamic>>(
      endpoint: "/categories",
    );

    if (response.isSuccess) {
      return Right(response.data!
          .map((element) => Categories.fromJson(element))
          .toList());
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }
}
