part of 'home_cubit.dart';

class HomeState {
  const HomeState();
}

class CategoryLoaded extends HomeState {
  late final List<CategoryEntity> categories;

  CategoryLoaded(this.categories);
}

class CategoryError extends HomeState {
  final String errorMessage;

  CategoryError({required this.errorMessage});
}
