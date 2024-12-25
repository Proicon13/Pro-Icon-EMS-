import 'package:equatable/equatable.dart';

class CountryModel extends Equatable {
  final int? id;
  final String name;

  const CountryModel({this.id, required this.name});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] != null ? json['id'] as int : 0,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  List<Object?> get props => [id, name];
}
