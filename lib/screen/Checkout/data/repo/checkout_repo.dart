import 'package:dartz/dartz.dart';
import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/end_points.dart';
import '../models/Chekout_responce_model.dart';
import '../models/checkout_model.dart';

class CartRepo {

  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, List<ActiveModel>>> checkout(
  ) async
  {
    try{
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.orders,
        isProtected: true,
      );
      var productModel = FetchCartDataModel.fromJson((response.data as Map<String,dynamic>));

      if(response.status){
        return right(productModel.orders?.active??[]);
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