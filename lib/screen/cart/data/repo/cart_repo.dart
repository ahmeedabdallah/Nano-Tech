import 'package:dartz/dartz.dart';
import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/end_points.dart';
import '../models/product_cart_model.dart';

class CartRepo {

  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, Unit>> placeOrder({
    required List<ProductCartModel> cart
  }) async
  {
    List<Map<String, dynamic>> cartData = cart.map((oldElement)=> {
      "product_id": oldElement.productModel.id,
      "quantity": oldElement.quantity
    }).toList();
  
    try{
      var response = await apiHelper.postRequest(
        endPoint: EndPoints.placeOrder,
        isProtected: true,
        isFormData: false,
        data: {
          "items": cartData
        }
      );

      if(response.status){
        return right(unit);
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