import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_cart_model.dart';
import '../../data/repo/cart_repo.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState>{
  CartCubit() : super(CartInitialState());
  static CartCubit get(context) => BlocProvider.of(context);

  List<ProductCartModel> cart = [];
  double total = 0;
  double tax=0;
  double delivery=0;
  double finalTotal = 0;

  void addProductToCart(ProductCartModel newProductCartModel){
    total +=  newProductCartModel.productModel.price * newProductCartModel.quantity;
    if (total>0){
      delivery=total/20;
      tax=total/10;
      finalTotal=total+tax+delivery;
    }
    else{
      tax=0;
      delivery=0;
      finalTotal=0;
    }

    // check if product is already in cart
    bool isInCart = false;
    for(int i =0; i < cart.length; i++){
      if(cart[i].productModel.id == newProductCartModel.productModel.id){
        // product is already in cart
        cart[i].quantity+= newProductCartModel.quantity;
        isInCart = true;
        break;
      }
    }
    if(isInCart == false){cart.add(newProductCartModel);}
    emit(CartAddProductState());
  }
  void removeProductFromCart(int index){
    total -= cart[index].productModel.price * cart[index].quantity;
    if (total>0){
      delivery=total/20;
      tax=total/10;
      finalTotal=total+tax+delivery;
    }
    else{
      tax=0;
      delivery=0;
      finalTotal=0;
    }
    cart.removeAt(index);
    emit(CartRemoveProductState());
  }

  void addProductQuantity(int productCartIndex){
    cart[productCartIndex].quantity++;
    total += cart[productCartIndex].productModel.price;
    if (total>0){
      delivery=total/20;
      tax=total/10;
      finalTotal=total+tax+delivery;
    }
    else{
      tax=0;
      delivery=0;
      finalTotal=0;
    }
    emit(CartAddQuantityState());
  }

  void removeProductQuantity(int productCartIndex){
    cart[productCartIndex].quantity--;
    total -= cart[productCartIndex].productModel.price;
    if (total>0){
      delivery=total/20;
      tax=total/10;
      finalTotal=total+tax+delivery;
    }
    else{
      tax=0;
      delivery=0;
      finalTotal=0;
    }
    emit(CartRemoveQuantityState());
  }
  
  void clearCart(){
    cart = [];
    total = 0;
    finalTotal=0;
    tax=0;
    delivery=0;
    emit(CartClearState());
  }

  void placeOrder()async
  {
    if(cart.isNotEmpty){
      emit(CartLoadingState());
      CartRepo repo = CartRepo();
      var result = await repo.placeOrder(cart: cart);
      result.fold(
        (error)=> emit(CartErrorState(error: error)),
        (u){
          emit(CartSuccessState());
          clearCart();
        }
      );
    }
  } 
}