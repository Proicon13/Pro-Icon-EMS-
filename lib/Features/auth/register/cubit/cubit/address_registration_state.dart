part of 'address_registration_cubit.dart';

enum RequestStatus { loading, success, error }

class AddressRegistrationState extends Equatable {
  final RequestStatus? status;
  final String? errorMessage;
  final List<String>? countries;
  final List<String>? cities;
  final Map<String, String>? citiesMap; // used to get id from city name

  const AddressRegistrationState(
      {this.status = RequestStatus.loading,
      this.citiesMap = const {},
      this.errorMessage = "",
      this.countries = const [],
      this.cities = const []});

  AddressRegistrationState copyWith(
      {RequestStatus? status,
      String? errorMessage,
      List<String>? countries,
      List<String>? cities,
      Map<String, String>? citiesMap}) {
    return AddressRegistrationState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        countries: countries ?? this.countries,
        cities: cities ?? this.cities,
        citiesMap: citiesMap ?? this.citiesMap);
  }

  @override
  List<Object> get props =>
      [status!, errorMessage!, countries!, cities!, citiesMap!];
}
