import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';

import '../../../../../Core/entities/category_entity.dart';

class SessionState extends Equatable {
  final String? selectedSessionMode;
  final List<CategoryEntity> categriesMangement;
  final List<ProgramEntity> programs;
  final String? errorMessage;
  final ProgramEntity? selectedProgram;

  SessionState(
      {this.selectedSessionMode = 'Program',
      this.categriesMangement = const [],
      this.selectedProgram = const ProgramEntity(),
      this.programs = const [],
      this.errorMessage = ""});

  SessionState copyWith({
    String? selectedSessionMode,
    String? errorMessage,
    List<CategoryEntity>? categriesMangement,
    List<ProgramEntity>? programs,
    ProgramEntity? selectedProgram,
  }) {
    return SessionState(
      selectedSessionMode: selectedSessionMode ?? this.selectedSessionMode,
      categriesMangement: categriesMangement ?? this.categriesMangement,
      programs: programs ?? this.programs,
      selectedProgram: selectedProgram ?? this.selectedProgram,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        selectedSessionMode,
        categriesMangement,
        programs,
        selectedProgram,
        errorMessage,
      ];
}
