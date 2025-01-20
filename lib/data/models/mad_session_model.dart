import 'package:equatable/equatable.dart';

class SessionModel extends Equatable {
  final int? id;
  final String? name;
  final CreatedByModel? createdBy;
  final DateTime? createdAt;

  const SessionModel({
    this.id,
    this.name,
    this.createdBy,
    this.createdAt,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'] as int?,
      name: json['name'] as String? ?? 'Unnamed Session',
      createdBy: json['createdBy'] != null
          ? CreatedByModel.fromJson(json['createdBy'] as Map<String, dynamic>)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
    );
  }

  SessionModel copyWith({
    int? id,
    String? name,
    CreatedByModel? createdBy,
    DateTime? createdAt,
  }) {
    return SessionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, createdBy, createdAt];
}

class CreatedByModel extends Equatable {
  final int? id;
  final String? fullname;

  const CreatedByModel({
    this.id,
    this.fullname,
  });

  factory CreatedByModel.fromJson(Map<String, dynamic> json) {
    return CreatedByModel(
      id: json['id'] as int?,
      fullname: json['fullname'] as String? ?? 'Unknown User',
    );
  }

  CreatedByModel copyWith({
    int? id,
    String? fullname,
  }) {
    return CreatedByModel(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
    );
  }

  @override
  List<Object?> get props => [id, fullname];
}

class MadSessionModel extends Equatable {
  final int? id;
  final SessionModel? session;

  const MadSessionModel({
    this.id,
    this.session,
  });

  factory MadSessionModel.fromJson(Map<String, dynamic> json) {
    return MadSessionModel(
      id: json['id'] as int?,
      session: json['session'] != null
          ? SessionModel.fromJson(json['session'] as Map<String, dynamic>)
          : null,
    );
  }

  MadSessionModel copyWith({
    int? id,
    SessionModel? session,
  }) {
    return MadSessionModel(
      id: id ?? this.id,
      session: session ?? this.session,
    );
  }

  @override
  List<Object?> get props => [id, session];
}
