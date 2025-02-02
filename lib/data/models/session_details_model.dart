import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/models/Client_mad_response.dart';
import 'package:pro_icon/data/models/category_model.dart';

import 'auto_session_model.dart';

class SessionDetailsModel extends Equatable {
  final int id;
  final AutoSessionModel? autoSession;
  final List<ProgramModel>? programs;
  final String type;
  final List<ClientMadResponse>? clientMads;

  SessionDetailsModel(
      {required this.id,
      this.autoSession,
      this.programs,
      this.clientMads,
      required this.type});

  factory SessionDetailsModel.fromJson(Map<String, dynamic> json) {
    return SessionDetailsModel(
      id: json['id'],
      autoSession: json['session'] != null
          ? AutoSessionModel.fromJson(json['session'])
          : null,
      programs: json['SessionClienPrograms'] != null
          ? (json['SessionClienPrograms'] as List)
              .map((i) => ProgramModel.fromJson(i))
              .toList()
          : null,
      type: json['type'],
      clientMads: json['SessionClientMad'] != null
          ? (json['SessionClientMad'] as List)
              .map((i) => ClientMadResponse.fromJson(i))
              .toList()
          : null,
    );
  }

  @override
  List<Object?> get props => [id, autoSession, programs, type];
}
