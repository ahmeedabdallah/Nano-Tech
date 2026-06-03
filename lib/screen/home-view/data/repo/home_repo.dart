import 'package:dartz/dartz.dart';
import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/end_points.dart';
import '../models/best_seller_model.dart';
import '../models/product_model.dart';
import '../models/recomended_product_model.dart' hide Products;
import '../models/slider_model.dart';

class HomeRepo {
  ApiHelper apiHelper = ApiHelper();
  Future<Either<String, List<BestSellerProducts>>> getBestSeller()async
  {
    try{
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.bestSellerProducts,
        isProtected: true
      );
      var getBestSellerModel = BestSellerModel.fromJson(response.data as Map<String,dynamic>);
      if(response.status){
        return right(getBestSellerModel.bestSellerProducts??[]);
      }
      else{
        return left(response.message);
      }
    }
    catch(e){
      return left(ApiResponse.fromError(e).message);
    }
  }

  Future<Either<String,List <Products>>> getProducts() async{
    try{

      var response = await apiHelper.getRequest(
          endPoint: EndPoints.products,
          isProtected: true
      );
      GetProductModel productModel = GetProductModel.fromJson((response.data as Map<String,dynamic>));

      if(response.status){
        return right(productModel.products??[]);
      }
      else{
        return left(response.message);
      }

    }
    catch(e){
      return left(ApiResponse.fromError(e).message);
    }
  }

  Future<Either<String, List<Sliders>>> getSlider() async{
    try{

      var response = await apiHelper.getRequest(
          endPoint: EndPoints.sliders,
      );
      SliderModel sliderModel = SliderModel.fromJson((response.data as Map<String,dynamic>));

      if(response.status){
        return right(sliderModel.sliders??[]);
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