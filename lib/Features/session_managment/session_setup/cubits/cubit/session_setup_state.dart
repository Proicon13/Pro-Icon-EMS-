import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/entities/automatic_session_entity.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';

import '../../../../../Core/entities/category_entity.dart';

enum SessionControlMode { program, auto }

class SessionState extends Equatable {
  final SessionControlMode? selectedSessionMode;
  final List<CategoryEntity> categriesMangement;
  final List<ProgramEntity> programs;
  final String? errorMessage;
  final ProgramEntity? selectedProgram;
  final List<AutomaticSessionEntity> automaticSessions;
  final AutomaticSessionEntity? selectedAutomaticSession;

  SessionState(
      {this.selectedSessionMode = SessionControlMode.program,
      this.categriesMangement = const [],
      this.selectedProgram = const ProgramEntity(),
      this.programs = const [],
      this.automaticSessions = const [],
      this.selectedAutomaticSession = const AutomaticSessionEntity(),
      this.errorMessage = ""});

  SessionState copyWith({
    SessionControlMode? selectedSessionMode,
    String? errorMessage,
    List<CategoryEntity>? categriesMangement,
    List<ProgramEntity>? programs,
    List<AutomaticSessionEntity>? automaticSessions,
    ProgramEntity? selectedProgram,
    AutomaticSessionEntity? selectedAutomaticSession,
  }) {
    return SessionState(
      automaticSessions: automaticSessions ?? this.automaticSessions,
      selectedSessionMode: selectedSessionMode ?? this.selectedSessionMode,
      categriesMangement: categriesMangement ?? this.categriesMangement,
      programs: programs ?? this.programs,
      selectedProgram: selectedProgram ?? this.selectedProgram,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedAutomaticSession:
          selectedAutomaticSession ?? this.selectedAutomaticSession,
    );
  }

  @override
  List<Object?> get props => [
        selectedSessionMode,
        categriesMangement,
        programs,
        selectedProgram,
        errorMessage,
        automaticSessions,
        selectedAutomaticSession
      ];
}
