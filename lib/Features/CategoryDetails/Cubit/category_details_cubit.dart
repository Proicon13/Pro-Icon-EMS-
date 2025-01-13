import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pro_icon/Core/entities/category_entity.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';

part 'category_details_state.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  CategoryDetailsCubit() : super(const CategoryDetailsState());

  void intialize(CategoryEntity categories, int index) {
    onCategoryChanged(categories, index);
  }

  void onCategoryChanged(CategoryEntity categories, int index) {
    emit(state.copyWith(
        currentCategoryIndex: index,
        programs: List.from(categories.programs!)));
  }
}
