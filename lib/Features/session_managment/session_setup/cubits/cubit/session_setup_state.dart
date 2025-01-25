

import 'package:pro_icon/Core/entities/program_entity.dart';

import '../../../../../Core/entities/category_entity.dart';


class SessionState {

  final String? selectedSessionMode;
  final List<CategoryEntity> categriesMangement;
  final List<ProgramEntity> programs;

  String errorMessage;

  SessionState({this.selectedSessionMode = 'Program' , this.categriesMangement = const [] , this.programs = const [] , this.errorMessage= ""});


  SessionState copyWith({String? selectedSessionMode , String ?errorMessage , List<CategoryEntity>? categriesMangement,List<ProgramEntity> ?programs  }) {
    return SessionState(
      selectedSessionMode: selectedSessionMode ?? this.selectedSessionMode,
      categriesMangement: categriesMangement ?? this.categriesMangement,
      programs: programs ?? this.programs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}



