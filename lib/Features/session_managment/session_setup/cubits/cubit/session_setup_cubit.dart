import 'package:bloc/bloc.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/Features/session_managment/session_setup/cubits/cubit/session_setup_state.dart';
import 'package:pro_icon/data/services/categories_services.dart';

import '../../../../../Core/entities/category_entity.dart';

class SessionCubit extends Cubit<SessionState> {
  final CategoriesServices categoriesServices;

  SessionCubit({required this.categoriesServices}) : super(SessionState());

  void getSessionManagementCategories() async {
    final result = await categoriesServices.getSessionManagmentCategory();

    result.fold((error) => emit(state.copyWith(errorMessage: error.message)),
        (categories) => emit(state.copyWith(categriesMangement: categories)));
  }

  void selectSessionMode(String mode) {
    emit(state.copyWith(selectedSessionMode: mode));
  }

  void selectCategory(CategoryEntity Category) async {
    emit(state.copyWith(programs: Category.programs));
  }

  void selectProgram(ProgramEntity program) {
    // TODO: Implement this to set selected program to the state
    // call it in onChange of programs dropdown
  }
}
