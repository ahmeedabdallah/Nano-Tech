abstract class CartState {}
class CartInitialState extends CartState{}
class CartAddProductState extends CartState{}
class CartRemoveProductState extends CartState{}
class CartAddQuantityState extends CartState{}
class CartRemoveQuantityState extends CartState{}
class CartClearState extends CartState{}

// API
class CartLoadingState extends CartState{}
class CartSuccessState extends CartState{}
class CartErrorState extends CartState{
  String error;
  CartErrorState({required this.error});
}