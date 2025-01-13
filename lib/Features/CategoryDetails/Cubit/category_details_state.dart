part of 'category_details_cubit.dart';

@immutable
class CategoryDetailsState extends Equatable {
  final int? currentCategoryIndex;
  final List<ProgramEntity>? programs;

  const CategoryDetailsState(
      {this.currentCategoryIndex = 0, this.programs = const []});

  CategoryDetailsState copyWith({
    int? currentCategoryIndex,
    List<ProgramEntity>? programs,
  }) {
    return CategoryDetailsState(
      currentCategoryIndex: currentCategoryIndex ?? this.currentCategoryIndex,
      programs: programs ?? this.programs,
    );
  }

  @override
  List<Object?> get props => [currentCategoryIndex, programs];
}
