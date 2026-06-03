import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/data/model/user_model.dart';
import '../../data/repo/get_categories.dart';
import 'get_user_data_state.dart';

class GetUserDataCubit extends Cubit<GetUserDataState>{
  GetUserDataCubit() : super(GetUserDataInitialState());
  static GetUserDataCubit get(context) => BlocProvider.of(context);


  void getUserDataPressed()async
  {
      emit(GetUserDataLoadingState());
      GetCategories repo = GetCategories();
      var result= await repo.getUserData();
      result.fold((String error)=> emit(GetUserDataErrorState(error)),
       (UserModel user)=> emit(GetUserDataSuccessState(user))
        );


  }

}