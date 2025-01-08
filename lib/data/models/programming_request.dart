import 'package:equatable/equatable.dart';

class ProgrammingRequest extends Equatable {
  final int? id;
  final String? status;
  final DateTime? createdAt;

  const ProgrammingRequest({this.id, this.status, this.createdAt});

  factory ProgrammingRequest.fromJson(Map<String, dynamic> json) {
    return ProgrammingRequest(
      id: json['id'] ?? 0,
      status: json['status'] ?? "Pending",
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['createdAt'] = createdAt;
    return data;
  }

  @override
  List<Object?> get props => [id, status, createdAt];
}
