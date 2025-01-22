import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/entities/automatic_session_entity.dart';
import 'package:pro_icon/Core/entities/category_entity.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/data/mappers/program_entity_mapper.dart';
import 'package:pro_icon/data/models/auto_session_model.dart';
import 'package:pro_icon/data/services/auto_session_service.dart';
import 'package:pro_icon/data/services/categories_services.dart';

part 'manage_custom_session_state.dart';

class ManageCustomSessionCubit extends Cubit<ManageCustomSessionState> {
  final CategoriesServices categoriesService;
  final AutoSessionService autoSessionService;
  ManageCustomSessionCubit(
      {required this.categoriesService, required this.autoSessionService})
      : super(const ManageCustomSessionState());

  void getSessionPrograms() async {
    emit(state.copyWith(getProgramsStatus: ManageCustomSessionStatus.loading));
    final response = await categoriesService.getCategorirs();
    response.fold((l) {
      emit(state.copyWith(getProgramsStatus: ManageCustomSessionStatus.error));
    }, (categories) {
      final programs = _populateProgramsFromCategories(categories);
      emit(state.copyWith(
          getProgramsStatus: ManageCustomSessionStatus.success,
          programs: programs));
    });
  }

  void onInit(AutomaticSessionEntity? session) {
    if (session != null) {
      emit(state.copyWith(
          sessionPrograms: session.sessionPrograms, isEditMode: true));
    }
  }

  void addSession(AutoSessionModel session) async {
    emit(state.copyWith(addSessionStatus: ManageCustomSessionStatus.loading));
    final response =
        await autoSessionService.createAutomaticSession(data: session);
    response.fold((l) {
      emit(state.copyWith(addSessionStatus: ManageCustomSessionStatus.error));
    }, (r) {
      emit(state.copyWith(
          addSessionStatus: ManageCustomSessionStatus.success,
          message: "Session Created Successfully"));
    });
  }

  void setEditMode(bool isEditMode) {
    emit(state.copyWith(isEditMode: isEditMode));
  }

  void onProgramSelected(ProgramEntity program) {
    final sessionProgram = SessionProgram(
        id: state.sessionPrograms.length + 1,
        duration: 10,
        pulse: 0,
        program: ProgramModelToEntityMapper.toModel(program),
        order: state.sessionPrograms.length + 1);
    emit(state
        .copyWith(sessionPrograms: [...state.sessionPrograms, sessionProgram]));
  }

  void onReorderProgram(int oldIndex, int newIndex) {
    // Adjust newIndex for downward reordering
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    // Create a mutable copy of the current session programs
    final newPrograms = List<SessionProgram>.from(state.sessionPrograms);

    // Remove the program from the old index
    final movedProgram = newPrograms.removeAt(oldIndex);

    // Insert the program at the new index
    newPrograms.insert(newIndex, movedProgram);

    // Update the `order` for all programs to match the new list order
    for (int i = 0; i < newPrograms.length; i++) {
      newPrograms[i] = newPrograms[i].copyWith(order: i + 1);
    }

    // Emit the updated state
    emit(state.copyWith(sessionPrograms: newPrograms));
  }

  void onDeleteSessionProgram(SessionProgram sessionProgram) {
    final newPrograms = List<SessionProgram>.from(state.sessionPrograms);
    newPrograms.remove(sessionProgram);
    emit(state.copyWith(sessionPrograms: newPrograms));
  }

  void onDurationChange(SessionProgram sessionProgram, bool isIncrease) {
    final newPrograms = state.sessionPrograms.map((program) {
      if (program == sessionProgram) {
        final currentDuration = program.duration ?? 0;
        final newDuration = isIncrease
            ? currentDuration + 5
            : (currentDuration - 5).clamp(10, double.infinity).toInt();
        return program.copyWith(duration: newDuration);
      }
      return program;
    }).toList();
    emit(state.copyWith(sessionPrograms: newPrograms));
  }

  void onPulseChange(SessionProgram sessionProgram, bool isIncrease) {
    final newPrograms = state.sessionPrograms.map((program) {
      if (program == sessionProgram) {
        final currentPulse = program.pulse ?? 0;
        final newPulse = isIncrease ? currentPulse + 1 : currentPulse - 1;
        return program.copyWith(pulse: newPulse);
      }
      return program;
    }).toList();
    emit(state.copyWith(sessionPrograms: newPrograms));
  }

  void editSession(AutoSessionModel session) async {
    emit(state.copyWith(editSessionStatus: ManageCustomSessionStatus.loading));
    final response = await autoSessionService.updateAutomaticSession(
        data: session, id: session.id!);
    response.fold((l) {
      emit(state.copyWith(editSessionStatus: ManageCustomSessionStatus.error));
    }, (r) {
      emit(state.copyWith(
          editSessionStatus: ManageCustomSessionStatus.success,
          message: "Session Updated Successfully"));
    });
  }

  List<ProgramEntity> _populateProgramsFromCategories(
      List<CategoryEntity> categories) {
    List<ProgramEntity> programs = [];
    for (final category in categories) {
      programs = [...programs, ...category.programs!];
    }
    return programs;
  }
}
