import 'package:equatable/equatable.dart';

class CountryModel extends Equatable {
  final int id;
  final String name;

  const CountryModel({required this.id, required this.name});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
