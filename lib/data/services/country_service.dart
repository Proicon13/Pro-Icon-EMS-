import 'package:dartz/dartz.dart';

import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/data/models/city_model.dart';
import 'package:pro_icon/data/models/country_model.dart';

import '../../Core/errors/failures.dart';

class CountryService {
  final BaseApiProvider _apiProvider;

  CountryService({required BaseApiProvider apiProvider})
      : _apiProvider = apiProvider;

  Future<Either<Failure, List<CountryModel>>> getCountries() async {
    // Send request and parse response
    final response = await _apiProvider.get<List<dynamic>>(
      endpoint: '/lookups/countries',
    );
    if (response.isSuccess) {
      // Map response data to List<CountryModel>
      final countries = response.data!
          .map((json) => CountryModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(countries);
    } else {
      // failure state
      return Left(ServerFailure(
          message: 'Failed to fetch countries: ${response.error!.message}'));
    }
  }

  Future<Either<Failure, List<CityModel>>> getCountryCities(
      {required String countryId}) async {
    // Send request with query parameters

    final response = await _apiProvider.get<List<dynamic>>(
      endpoint: '/lookups/cities/$countryId',
    );

    if (response.isSuccess) {
      // Map response data to List<CityModel>
      final cities = response.data!
          .map((json) => CityModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(cities);
    } else {
      return Left(ServerFailure(
          message: 'Failed to fetch cities: ${response.error!.message}'));
    }
  }
}
