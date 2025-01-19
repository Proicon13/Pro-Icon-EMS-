import 'package:equatable/equatable.dart';

class Mad extends Equatable {
  final int? id;
  final int? serialNo;
  final bool? isActive;

  Mad({this.id, this.serialNo, this.isActive = true});

  factory Mad.fromJson(Map<String, dynamic> json) => Mad(
        id: json['id'],
        serialNo: json['sNo'],
      );

  Mad copyWith({int? id, int? serialNo, bool? isActive}) => Mad(
        id: id ?? this.id,
        serialNo: serialNo ?? this.serialNo,
        isActive: isActive ?? this.isActive,
      );
  @override
  List<Object?> get props => [id, serialNo, isActive];
}
