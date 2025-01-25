import 'package:pro_icon/Core/entities/program_entity.dart';

import '../../../../../Core/entities/category_entity.dart';

class SessionState {
  // TODO: Always Extend the state class with Equatable to make it easy to compare between states
  // TODO: Add all fields of state in props for the Equatable to compare between states
  final String? selectedSessionMode;
  final List<CategoryEntity> categriesMangement;
  final List<ProgramEntity> programs;
  final String? errorMessage;
  // TODO: ADD selected Program to the state  (ProgramEntity selectedProgram) and add it to copyWith also to update it and give it a default value ProgramEntity()
  //

  SessionState(
      {this.selectedSessionMode = 'Program',
      this.categriesMangement = const [],
      this.programs = const [],
      this.errorMessage = ""});

  SessionState copyWith(
      {String? selectedSessionMode,
      String? errorMessage,
      List<CategoryEntity>? categriesMangement,
      List<ProgramEntity>? programs}) {
    return SessionState(
      selectedSessionMode: selectedSessionMode ?? this.selectedSessionMode,
      categriesMangement: categriesMangement ?? this.categriesMangement,
      programs: programs ?? this.programs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
