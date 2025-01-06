part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

  class CategoryLoaded extends HomeState {

  late final  List<Categories> categories;

  CategoryLoaded(this.categories);


  }

  class CategoryError extends HomeState {

  final String errorMessage;

  CategoryError ({required this.errorMessage});

  }
