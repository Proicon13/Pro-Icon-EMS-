import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/models/categories_model.dart';

part 'category_details_state.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  CategoryDetailsCubit() : super(const CategoryDetailsState());

  void intialize(Categories categories, int index) {
    onCategoryChanged(categories, index);
  }

  void onCategoryChanged(Categories categories, int index) {
    emit(state.copyWith(
        currentCategoryIndex: index,
        programs: List.from(categories.programs!)));
  }
}
