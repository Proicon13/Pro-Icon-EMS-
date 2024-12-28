part of 'address_registration_cubit.dart';

enum RequestStatus { loading, success, error }

class RegionState extends Equatable {
  final RequestStatus? status;
  final String? errorMessage;
  final List<CountryModel>? countries;
  final List<CityModel>? cities;
  final Map<CountryModel, List<CityModel>>?
      countriesMap; // used to get id from city name

  const RegionState(
      {this.status = RequestStatus.loading,
      this.countriesMap = const {},
      this.errorMessage = "",
      this.countries = const [],
      this.cities = const []});

  RegionState copyWith(
      {RequestStatus? status,
      String? errorMessage,
      List<CountryModel>? countries,
      List<CityModel>? cities,
      Map<CountryModel, List<CityModel>>? countriesMap}) {
    return RegionState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        countries: countries ?? this.countries,
        cities: cities ?? this.cities,
        countriesMap: countriesMap ?? this.countriesMap);
  }

  @override
  List<Object> get props =>
      [status!, errorMessage!, countries!, cities!, countriesMap!];
}
