import 'package:equatable/equatable.dart';

class Muscle extends Equatable {
  final int? id;
  final String? name;

  Muscle({this.id, this.name});

  factory Muscle.fromJson(Map<String, dynamic> json) {
    return Muscle(
      id: json['id'] ?? 0,
      name: json['name'] ?? "Not Defined",
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  List<Object?> get props => [id, name];
}
