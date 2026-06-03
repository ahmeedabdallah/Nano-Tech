import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helper/app_popup.dart';
import '../../../core/utils/color.dart';
import '../../../helper/my_navigator.dart';
import '../../Checkout/views/checkout_view.dart';
import '../../home-view/views/home_view.dart';
import '../cubit/cart_cubit/cart_cubit.dart';
import '../cubit/cart_cubit/cart_state.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        leading: IconButton(
          onPressed: () {
            MyNavigator.goto(context, HomeView(),type: NavigatorType.push);
          },
          icon: Icon(Icons.chevron_left, color: AppColor.primary),
        ),
        title: Text(
          'Cart',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: AppColor.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: CartCubit.get(context).clearCart,
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartErrorState) {
            SnackBarPopUp().show(
              context: context,
              message: state.error,
              state: PopUpState.error,
            );
          } else if (state is CartSuccessState) {
            SnackBarPopUp().show(
              context: context,
              message: 'Order Checked successfully',
              state: PopUpState.success,
            );
            MyNavigator.goto(context, CheckoutView());
          }
        },
        builder: (context, state) {
          var cubit = CartCubit.get(context);
          return Stack(
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
                      Text(
                        'You have ${cubit.cart.length} items in the cart',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 100.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: Image.network(
                                        cubit.cart[index].productModel.imagePath ??
                                            '',
                                        width: 90.w,
                                        height: 80.h,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        cubit.cart[index].productModel.name ?? '',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.black,
                                        ),
                                      ),
                                      Text(
                                        '\$${cubit.cart[index].productModel.price}',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w300,
                                          color: Color(0xff391713),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            cubit.removeProductFromCart(index),
                                        icon: Icon(Icons.delete_outlined),
                                        color: AppColor.primary,
                                        iconSize: 15,
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              (cubit.cart[index].quantity >= 2)
                                                  ? cubit.removeProductQuantity(
                                                      index,
                                                    )
                                                  : () {};
                                            },
                                            icon: Icon(
                                              Icons.remove_circle,
                                              size: 18,
                                            ),
                                            color: (cubit.cart[index].quantity >= 2)
                                                ? AppColor.primary
                                                : Colors.white,
                                          ),
                                          Text('${cubit.cart[index].quantity}'),
                                          IconButton(
                                            onPressed: () =>
                                                cubit.addProductQuantity(index),
                                            icon: Icon(Icons.add_circle, size: 18),
                                            color: AppColor.primary,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: REdgeInsets.symmetric(horizontal: 10),
                                width: double.infinity,
                                height: 0.5,
                                color: AppColor.backgroundColor,
                              ),
                            ],
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 20),
                          itemCount: cubit.cart.length,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding:  REdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColor.black,
                              ),
                            ),
                            Text(
                              "\$${cubit.total}",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColor.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding:  REdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tax and Fees",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColor.black,
                              ),
                            ),
                            Text(
                              "\$${cubit.tax}",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColor.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding:  REdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColor.black,
                              ),
                            ),
                            Text(
                              "\$${cubit.delivery}",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColor.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),

                      Container(
                        padding: REdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        height: 0.5,
                        color: AppColor.backgroundColor,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding:  REdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColor.black,
                              ),
                            ),
                            Text(
                              "\$${cubit.finalTotal}",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColor.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),

                      state is CartLoadingState
                          ? CircularProgressIndicator()
                          : SizedBox(
                              width: 207.w,
                              height: 50.h,
                              child: ElevatedButton(
                                onPressed:(){
                                  cubit.placeOrder();
                                  },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.backgroundColor,
                                ),
                                child: Text(
                                  'Checkout',
                                  style: TextStyle(color: AppColor.primary),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
