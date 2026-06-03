import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fod_app/helper/my_navigator.dart';
import 'package:fod_app/screen/cart/views/cart_view.dart';
import '../../../core/utils/color.dart';
import '../../cart/cubit/cart_cubit/cart_cubit.dart';
import '../../cart/data/models/product_cart_model.dart';
import '../cubit/Item_cubit/Item_cubit.dart';
import '../cubit/Item_cubit/item_state.dart';

class ItemView extends StatelessWidget {
  const ItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemCubit, ItemState>(
      builder: (context, state) {
        var cubit = ItemCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.backgroundColor,
            leading: IconButton(
              onPressed: () {
                cubit.clearItem();

                MyNavigator.goback(context);
              },
              icon: Icon(Icons.chevron_left, color: AppColor.primary),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text((cubit.item.isEmpty)?"":cubit.item.first.itemModel.name!),
                    SizedBox(width: 20.w),
                    Icon(Icons.circle, color: AppColor.primary, size: 6),
                    Spacer(),
                    InkWell(
                      onTap: ()=>cubit.onPressFavorite(),
                      child: CircleAvatar(
                        radius: 9.r,
                        backgroundColor: Colors.white,
                        child: Icon(
                          size: 11,
                          Icons.favorite,
                          color: cubit.colorOfIcon,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Container(
                  width: 34.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColor.primary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text((cubit.item.isEmpty)?"":
                        '${cubit.item.first.itemModel.rating}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColor.white,
                        ),
                      ),
                      Icon(Icons.star, color: Color(0xffF4BA1B), size: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(color: AppColor.backgroundColor),
              ),
              Align(
                alignment: Alignment.bottomCenter,

                child: Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  width: double.infinity,
                  padding: REdgeInsets.all(19),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35.r),
                      topLeft: Radius.circular(35.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 229.h,
                            width: 339.w,
                            padding: REdgeInsets.all(19),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(36.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(36.r),
                              child: Image.network((cubit.item.isEmpty)?"":
                                cubit.item.first.itemModel.imagePath ?? '',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: REdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text((cubit.item.isEmpty)?"":
                                  '\$${(cubit.item.first.itemModel.price) * cubit.quantity}',
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.primary,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        (cubit.quantity >= 2)
                                            ? cubit.removeItemQuantity()
                                            : () {};
                                      },
                                      icon: Icon(Icons.remove_circle, size: 22),
                                      color: (cubit.quantity >= 2)
                                          ? AppColor.primary
                                          : Colors.white,
                                    ),
                                    Text('${cubit.quantity}'),
                                    IconButton(
                                      onPressed: () => cubit.addItemQuantity(),
                                      icon: Icon(Icons.add_circle, size: 22),
                                      color: AppColor.primary,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: REdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            height: 0.5,
                            color: AppColor.backgroundColor,
                          ),
                          SizedBox(height: 20.h),
                          Text((cubit.item.isEmpty)?"":
                            cubit.item.first.itemModel.description ?? '',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Center(
                            child: SizedBox(
                              width: 180.w,
                              height: 40.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  CartCubit.get(context).addProductToCart(
                                      ProductCartModel(productModel: cubit.item.first.itemModel, quantity: cubit.quantity));
                                    MyNavigator.goto(context, CartView());
                                    cubit.clearItem();
                                  },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.shopping_bag),
                                    SizedBox(width: 8.w,),
                                    Text(
                                      'Add to Cart',
                                      style: TextStyle(color: AppColor.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
