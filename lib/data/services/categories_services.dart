import 'package:dartz/dartz.dart';
import 'package:pro_icon/Core/errors/failures.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/models/category_model.dart';

import '../../Core/entities/category_entity.dart';
import '../mappers/category_entity_mapper.dart';

class CategoriesServices {
  final BaseApiProvider baseApiProvider;

  CategoriesServices({required this.baseApiProvider});

  Future<Either<Failure, List<CategoryEntity>>> getCategorirs() async {
    final response = await baseApiProvider.get<List<dynamic>>(
      endpoint: "/categories",
    );

    if (response.isSuccess) {
      return Right(response.data!
          .map((element) => CategoryModelToEntityMapper.toEntity(
              CategoryModel.fromJson(element)))
          .toList());
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }
}
