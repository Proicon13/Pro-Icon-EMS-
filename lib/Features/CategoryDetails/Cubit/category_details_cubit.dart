import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pro_icon/data/models/categories_model.dart';

part 'category_details_state.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  CategoryDetailsCubit() : super(const CategoryDetailsState());

  void onInitialize(Categories category, int index) {
    emit(state.copyWith(
        currentCategoryIndex: index, programs: List.from(category.programs!)));
  }

  void setCurrentCategoryIndex(int index) {
    emit(state.copyWith(currentCategoryIndex: index));
  }
}
