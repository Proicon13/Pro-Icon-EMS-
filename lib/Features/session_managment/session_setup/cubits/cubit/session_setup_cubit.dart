import 'package:bloc/bloc.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/Features/session_managment/session_setup/cubits/cubit/session_setup_state.dart';
import 'package:pro_icon/data/services/auto_session_service.dart';
import 'package:pro_icon/data/services/categories_services.dart';

import '../../../../../Core/entities/automatic_session_entity.dart';
import '../../../../../Core/entities/category_entity.dart';
import '../../../../../Core/networking/api_constants.dart';

class SessionCubit extends Cubit<SessionState> {
  final CategoriesServices categoriesServices;
  final AutoSessionService autoSessionService;

  SessionCubit(
      {required this.categoriesServices, required this.autoSessionService})
      : super(SessionState());

  void getSessionManagementCategories() async {
    emit(state.copyWith(isLoading: true));
    final result = await categoriesServices.getSessionManagmentCategory();

    result.fold(
        (error) =>
            emit(state.copyWith(errorMessage: error.message, isLoading: false)),
        (categories) {
      final allPrograms = _populateAllPrograms(categories);
      emit(state.copyWith(
          categriesMangement: categories,
          allPrograms: allPrograms,
          isLoading: false,
          errorMessage: ""));
    });
  }

  List<ProgramEntity> _populateAllPrograms(List<CategoryEntity> categories) {
    List<ProgramEntity> programs = [];

    for (final category in categories) {
      programs = [...programs, ...category.programs!];
    }
    return programs;
  }

  void selectSessionMode(SessionControlMode mode) {
    emit(state.copyWith(selectedSessionMode: mode));
    if (mode == SessionControlMode.auto) {
      getAutomaticSessions();
    }
  }

  void selectCategory(CategoryEntity Category) async {
    emit(state.copyWith(programs: Category.programs));
  }

  void selectProgram(ProgramEntity program) {
    emit(state.copyWith(selectedProgram: program));
  }

  void selectAutomaticSession(AutomaticSessionEntity session) {
    emit(state.copyWith(selectedAutomaticSession: session));
  }

  void getAutomaticSessions() async {
    if (state.automaticSessions.isNotEmpty) return;
    emit(state.copyWith(isLoading: true));

    final response = await autoSessionService.getAutomaticSessions(
      type: "AUTOMATIC",
      perPage: 2 * ApiConstants.defaultPerPage,
    );

    response.fold(
        (error) =>
            emit(state.copyWith(errorMessage: error.message, isLoading: false)),
        (sessions) async {
      final customSessions = await getCustomAutomaticSessions();
      final allSessions = [...sessions.data, ...customSessions];
      emit(state.copyWith(
          isLoading: false, automaticSessions: allSessions, errorMessage: ""));
    });
  }

  Future<List<AutomaticSessionEntity>> getCustomAutomaticSessions() async {
    final response = await autoSessionService.getAutomaticSessions(
      type: "CUSTOM",
      perPage: 5 * ApiConstants.defaultPerPage,
    );

    return response.fold((error) => [], (sessions) => sessions.data);
  }
}
