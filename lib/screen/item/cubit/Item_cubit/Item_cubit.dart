import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/product_item_model.dart';
import 'item_state.dart';

class ItemCubit extends Cubit<ItemState>{
  ItemCubit() : super(ItemInitialState());
  static ItemCubit get(context) => BlocProvider.of(context);

  List<ProductItemModel> item = [];
  double total = 0;
  int quantity=1;

  bool isFav = false;

  Color get colorOfIcon =>
      isFav ? Colors.red : Colors.grey;

  void addProductToItem(ProductItemModel newItemModel){
    total +=  newItemModel.itemModel.price * newItemModel.quantity;
    bool isInItem = false;
    for(int i =0; i < item.length; i++){
      if(item[i].itemModel.id == newItemModel.itemModel.id){
        // product is already in cart
        item[i].quantity+= newItemModel.quantity;
        isInItem = true;
        break;
      }
    }
    if(isInItem == false){item.add(newItemModel);}
    emit(ItemAddProductState());
    item.add(newItemModel);
  }
  int selectedCategoryIndex =0;
  void selectCategory(int index){
    selectedCategoryIndex = index;
    emit(ItemSelectState());
  }

  void addItemQuantity(){
quantity++;
    emit(ItemAddQuantityState());
  }
  void removeItemQuantity(){
quantity--;
    emit(ItemRemoveQuantityState());
  }
  void clearItem(){
    item = [];
    total = 0;
    quantity=1;
    emit(ItemClearState());
  }
   void onPressFavorite(){
     isFav = !isFav;
     emit (ChangeColorIconState());
   }


}