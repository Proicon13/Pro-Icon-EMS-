import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'mad.g.dart';

@HiveType(typeId: 1)
class Mad extends Equatable {
  @HiveField(1)
  final int id;

  @HiveField(2)
  final int serialNo;

  @HiveField(3)
  final bool isActive;

  Mad({
    required this.id,
    required this.serialNo,
    required this.isActive,
  });

  factory Mad.fromJson(Map<String, dynamic> json) {
    return Mad(
      id: json['id'],
      serialNo: json['sNo'],
      isActive: json['isActive'],
    );
  }

  Mad copyWith({
    int? id,
    int? serialNo,
    bool? isActive,
  }) {
    return Mad(
      id: id ?? this.id,
      serialNo: serialNo ?? this.serialNo,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serialNo': serialNo,
      'isActive': isActive,
    };
  }

  @override
  List<Object?> get props => [id, serialNo, isActive];
}
