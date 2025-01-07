import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pro_icon/Core/errors/failures.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/models/categories_model.dart';

class CategoriesServices {
  final BaseApiProvider baseApiProvider;

  CategoriesServices({required this.baseApiProvider});

  Future<Either<Failure, List<Categories>>> getCategorirs() async {
    final response = await baseApiProvider.get<List<dynamic>>(
        endpoint: "/categories",
        options: Options(headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjcsImVtYWlsIjoib21hcnNhYnJ5ODk4OUBnbWFpbC5jb20iLCJpYXQiOjE3MzQ4ODA4MDl9.jFA1PLagX6tM_g231YcQ9uP9QznRNJF3kgYXk-bC42U'
        }));

    if (response.isSuccess) {
      return Right(response.data!
          .map((element) => Categories.fromJson(element))
          .toList());
    } else {
      return Left(ServerFailure(message: response.error!.message));
    }
  }
}
