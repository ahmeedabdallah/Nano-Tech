

abstract class GetCategoriesState {}

class GetCategoriesInitialState extends GetCategoriesState {}

class GetCategoriesLoadingState extends GetCategoriesState {}
class GetCategoriesInedxChangedState extends GetCategoriesState {}

class GetCategoriesSuccessState extends GetCategoriesState {}

class GetCategoriesErrorState extends GetCategoriesState {
  String error;
  GetCategoriesErrorState({required this.error});
}