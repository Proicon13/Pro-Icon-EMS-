import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pro_icon/data/models/categories_model.dart';

import '../../../data/services/categories_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CategoriesServices categoriesServices;

  HomeCubit({required this.categoriesServices}) : super(HomeInitial());

  void getCategories() async {
    final result = await categoriesServices.getCategorirs();

    result.fold((error) => {emit(CategoryError(errorMessage: error.message))},
        (categoryItems) => {emit(CategoryLoaded(categoryItems))});
  }
}
