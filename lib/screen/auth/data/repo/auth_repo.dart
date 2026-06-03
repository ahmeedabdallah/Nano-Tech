import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/end_points.dart';
import '../model/basic_response_model.dart';
import '../model/login_response_model.dart';
import '../model/user_model.dart';

class AuthRepo {

  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, UserModel>> register({
    required String email,
    required String password,
    required String name,
    required String phone,



  })async{
    try{
      
      var response =  await apiHelper.postRequest(
      endPoint: EndPoints.register,
      data: {
        'email': email,
        'password': password,
        'phone' : phone,
        'name' : name,
      }
    );
    
    var basicResponseModel = BasicResponseModel.fromJson(response.data as Map<String,dynamic>);
    if(basicResponseModel.status == true){
      return right(response.data);
    }
    else{
      return left(response.message);
    }
    
    }
    catch(e){
      return left(ApiResponse.fromError(e).message);
    }
  }


  Future<Either<String, UserModel>> login ({
    required String email,
    required String password
  })async
  {
    try{
      var response = await apiHelper.postRequest(
        endPoint: EndPoints.login,
        data: {
          'email': email,
          'password': password
        }
      );
      var loginModel = LoginResponseModel.fromJson(response.data as Map<String,dynamic>);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if(loginModel.accessToken != null){
        await prefs.setString('access_token', loginModel.accessToken!);
      }  
      if(loginModel.refreshToken != null){
        await prefs.setString('refresh_token', loginModel.refreshToken!);
      }  

      if(loginModel.status == true && loginModel.user != null){
        return right(loginModel.user!);
      }
      else
      {
        return left(response.message);
      }

    }
    catch(e){
      return left(ApiResponse.fromError(e).message);
    }

  }

}