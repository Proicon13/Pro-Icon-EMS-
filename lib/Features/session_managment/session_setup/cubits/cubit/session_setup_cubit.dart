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
    final result = await categoriesServices.getSessionManagmentCategory();

    result.fold(
        (error) => emit(state.copyWith(errorMessage: error.message)),
        (categories) => emit(
            state.copyWith(categriesMangement: categories, errorMessage: "")));
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

    final response = await autoSessionService.getAutomaticSessions(
      type: "AUTOMATIC",
      perPage: 2 * ApiConstants.defaultPerPage,
    );

    response.fold(
        (error) => emit(state.copyWith(errorMessage: error.message)),
        (sessions) => emit(state.copyWith(
            automaticSessions: sessions.data, errorMessage: "")));
  }
}
