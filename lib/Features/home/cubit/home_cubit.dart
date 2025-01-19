import 'package:bloc/bloc.dart';
import 'package:pro_icon/Core/entities/category_entity.dart';

import '../../../data/services/categories_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CategoriesServices categoriesServices;

  HomeCubit({required this.categoriesServices}) : super(const HomeState());

  void getCategories() async {
    final result = await categoriesServices.getCategorirs();

    result.fold((error) => {emit(CategoryError(errorMessage: error.message))},
        (categoryItems) => {emit(CategoryLoaded(categoryItems))});
  }
}
