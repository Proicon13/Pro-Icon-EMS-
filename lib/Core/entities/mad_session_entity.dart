import 'package:equatable/equatable.dart';

class MadSessionEntity extends Equatable {
  final int? id;
  final String? captainName;
  final DateTime? date;

  MadSessionEntity({this.id, this.captainName, this.date});

  @override
  List<Object?> get props => [id, captainName, date];
}
