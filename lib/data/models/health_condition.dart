import 'package:equatable/equatable.dart';

class HealthCondition extends Equatable {
  final int id;
  final String name;

  HealthCondition({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

class Injury extends HealthCondition {
  Injury({required int id, required String name}) : super(id: id, name: name);
  @override
  List<Object?> get props => [id, name];

  factory Injury.fromJson(Map<String, dynamic> json) {
    return Injury(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class Disease extends HealthCondition {
  Disease({required int id, required String name}) : super(id: id, name: name);
  @override
  List<Object?> get props => [id, name];

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      id: json['id'],
      name: json['name'],
    );
  }
}
