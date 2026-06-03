import 'package:dartz/dartz.dart';
import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/end_points.dart';
import '../../../auth/data/model/user_model.dart';
import '../models/get_categories_response_model.dart';

class GetCategories {
  ApiHelper apiHelper = ApiHelper();
  Future<Either<String, List<CategoryModel>>> getCategories()async
  {
    try{
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.categories,
        isProtected: true
      );
      var getTasksModel = GetCategoriesResponseModel.fromJson(response.data as Map<String,dynamic>);
      if(response.status){
        return right(getTasksModel.categories??[]);
      }
      else{
        return left(response.message);
      }
    }
    catch(e){
      return left(ApiResponse.fromError(e).message);
    }
  }


  Future<Either<String, UserModel>> getUserData() async{
    try{

      var response = await apiHelper.getRequest(
        endPoint: EndPoints.getUserData,
        isProtected: true
      );
      if(response.status){
        UserModel user = UserModel.fromJson((response.data as Map<String,dynamic>)['user'] as Map<String,dynamic>);
        return right(user);
      }
      else{
        return left(response.message);
      }

    }
    catch(e){
      return left(ApiResponse.fromError(e).message);
    }
  }
}