import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/entities/control_panel_mad.dart';

class CreateSessionRequest extends Equatable {
  final int? sessionId;
  final String mode;
  final List<int>? programsIds;
  final List<ControlPanelMad>? mads;

  CreateSessionRequest(
      {this.sessionId, required this.mode, this.programsIds, this.mads});

  Map<String, dynamic> toJson() => {
        "sessionId": sessionId,
        "type": mode,
        "SessionClienPrograms":
            programsIds?.map((e) => {"programId": e}).toList(),
        "SessionClientMad": mads?.map((e) => e.toJson()).toList(),
      };
  @override
  List<Object?> get props => [sessionId, mode, programsIds, mads];
}
