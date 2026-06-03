import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/get_categories_response_model.dart';
import '../../data/repo/get_categories.dart';
import 'get_categories_state.dart';


class GetCategoriesCubit extends Cubit<GetCategoriesState>{
  GetCategoriesCubit() : super(GetCategoriesInitialState());
  static GetCategoriesCubit get(context) => BlocProvider.of(context);

  int selectedCategoryIndex =0;
  void selectCategory(int index){
    selectedCategoryIndex = index;
    emit(GetCategoriesInedxChangedState());
  }

 List<CategoryModel> categories = [];
  void getCategories()async
  {
    emit(GetCategoriesLoadingState());
    GetCategories repo = GetCategories();
    var result = await repo.getCategories();
    result.fold((error)=> emit(GetCategoriesErrorState(error: error)),
     (List<CategoryModel> repoCategories){
      categories = repoCategories;
      emit(GetCategoriesSuccessState());
     });
  }
}