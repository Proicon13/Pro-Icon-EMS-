import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/models/city_model.dart';
import 'package:pro_icon/data/services/country_service.dart';

part 'region_state.dart';

class RegionCubit extends Cubit<RegionState> {
  final CountryService countryService;
  RegionCubit({required this.countryService}) : super(const RegionState());

  void getCountries() async {
    final result = await countryService.getCountries();
    result.fold((failure) {
      emit(state.copyWith(
          errorMessage: failure.message, status: RequestStatus.error));
    }, (countries) async {
      if (countries.isEmpty) {
        emit(state.copyWith(
            errorMessage: 'No countries found', status: RequestStatus.error));
      } else {
        // Fetch cities for the first country
        final cities = await getCountryCities(countries.first.id.toString());

        // Get list of country and city names for state
        final countryNames = countries.map((c) => c.name).toList();
        final cityNames = cities.map((c) => c.name).toList();
        final cityIds = cities.map((c) => c.id.toString()).toList();

        final citiesMap = Map<String, String>.fromIterables(cityNames, cityIds);

        emit(state.copyWith(
          countries: countryNames,
          cities: cityNames,
          errorMessage: "",
          citiesMap: citiesMap,
          status: RequestStatus.success,
        ));
      }
    });
  }

  Future<List<CityModel>> getCountryCities(String countryId) async {
    final result = await countryService.getCountryCities(countryId: countryId);
    return result.fold((failure) {
      emit(state.copyWith(
          errorMessage: failure.message, status: RequestStatus.error));
      return [];
    }, (cities) {
      return cities;
    });
  }
}
