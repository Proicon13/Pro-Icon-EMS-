import 'package:equatable/equatable.dart';

import 'country_model.dart';

class CityModel extends Equatable {
  final int id;
  final String name;
  final CountryModel country;

  const CityModel(
      {required this.id, required this.name, required this.country});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as int,
      name: json['name'] as String,
      country: CountryModel.fromJson(json['country'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [id, name, country];
}
