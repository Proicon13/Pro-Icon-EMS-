import 'package:equatable/equatable.dart';

class Cycle extends Equatable {
  final int? id;
  final num? frequency;
  final num? adjustment;

  Cycle({this.id, this.frequency, this.adjustment});

  factory Cycle.fromJson(Map<String, dynamic> json) {
    return Cycle(
      id: json['id'] ?? 0,
      frequency: json['frequancy'] ?? 0,
      adjustment: json['value'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'frequancy': frequency,
        'value': adjustment,
      };

  Cycle copyWith({int? id, num? frequency, num? adjustment}) => Cycle(
      id: id ?? this.id,
      frequency: frequency ?? this.frequency,
      adjustment: adjustment ?? this.adjustment);
  @override
  List<Object?> get props => [id, frequency, adjustment];
}
