import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/models/city_model.dart';
import 'package:pro_icon/data/models/country_model.dart';
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
        final cities = await getCountryCities(countries.first);
        // put first country and cities in map
        final updatedCountriesMap =
            _populateCountriesMapField(countries.first, cities);

        emit(state.copyWith(
          countries: countries,
          cities: cities,
          errorMessage: "",
          countriesMap: updatedCountriesMap,
          status: RequestStatus.success,
        ));
      }
    });
  }

  Future<List<CityModel>> getCountryCities(CountryModel country) async {
    final result =
        await countryService.getCountryCities(countryId: country.id.toString());
    return result.fold((failure) {
      emit(state.copyWith(
          errorMessage: failure.message, status: RequestStatus.error));
      return [];
    }, (cities) {
      return cities;
    });
  }

  Future<void> onSelectCountry(CountryModel country) async {
    // check if country is in map and has cities
    if (state.countriesMap!.containsKey(country)) {
      emit(state.copyWith(
        cities: List.from(state.countriesMap![country]!),
      ));
    } else {
      // fetch cities for country
      final cities = await getCountryCities(country);
      // add country and cities to map

      final updatedCountriesMap = _populateCountriesMapField(country, cities);
      emit(state.copyWith(
        cities: cities,
        countriesMap: updatedCountriesMap,
      ));
    }
  }

  Map<CountryModel, List<CityModel>> _populateCountriesMapField(
      CountryModel country, List<CityModel> cities) {
    final countriesMap =
        Map<CountryModel, List<CityModel>>.from(state.countriesMap ?? {});
    countriesMap[country] = cities;
    return countriesMap;
  }
}
