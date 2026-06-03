import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fod_app/screen/Checkout/cubit/checkout_cubit/checkout_cubit.dart';
import '../../../core/helper/app_popup.dart';
import '../../../core/utils/color.dart';
import '../../../helper/my_navigator.dart';
import '../../home-view/views/home_view.dart';
import '../cubit/CheckoutState/checkout_state.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        leading: IconButton(
          onPressed: () {
            MyNavigator.goto(context, HomeView(), type: NavigatorType.push);
          },
          icon: Icon(Icons.chevron_left, color: AppColor.primary),
        ),
        title: Text(
          'Confirm Order',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: AppColor.white,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context)=>CheckoutCubit()..fetchProducts(),
        child: BlocConsumer<CheckoutCubit, CheckoutState>(
          listener: (context, state) {
            if (state is CheckoutErrorState) {
              SnackBarPopUp().show(
                context: context,
                message: state.error,
                state: PopUpState.error,
              );
            } else if (state is CheckoutSuccessState) {
              SnackBarPopUp().show(
                context: context,
                message: 'Order placed successfully',
                state: PopUpState.success,
              );
            }
          },
          builder: (context, state) {
            if (state is CheckoutSuccessState) {
              var cubit = CheckoutCubit.get(context);

              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.12,
                    decoration: BoxDecoration(color: AppColor.backgroundColor),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.85,
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
                          Row(
                            children: [
                              Text(
                                'Shipping Address',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.black,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Open Maps',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          Container(
                            width: double.infinity,
                            padding: REdgeInsets.all(19),
                            decoration: BoxDecoration(
                              color: Color(0xffF3E9B5),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text('22 Minya ElQamh View Drive'),
                          ),
                          SizedBox(height: 40.h,),
                          Text(
                            'Order Summary',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColor.black,
                            ),
                          ),

                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                final order =cubit.item[index];

                                final item1=order.items??[];
                                item1.map((item){
                                return Column(
                                  children: [
                                    Container(
                                      padding: REdgeInsets.symmetric(
                                          horizontal: 10),
                                      width: double.infinity,
                                      height: 0.5,
                                      color: AppColor.backgroundColor,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 100.w,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                20.r),
                                            child: Image.network(
                                              item
                                                  .imagePath ?? ""
                                              ,
                                              width: 90.w,
                                              height: 80.h,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20.w),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                                  item.name ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.black,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                  '${ item.quantity}',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w300,
                                                    color: Color(0xff391713),
                                                  ),
                                                ),
                                                Text(
                                                  '\$${ item.price}',
                                                  style: TextStyle(
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.primary,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),


                                  ],
                                );
                              });},
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 20),
                              itemCount: 2
                              ,
                            ),
                          ),
                          SizedBox(height: 10),
                          /* Padding(
                          padding: REdgeInsets.symmetric(horizontal: 20),
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
                                "\$${cubit.item}",
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
                          padding: REdgeInsets.symmetric(horizontal: 20),
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
                          padding: REdgeInsets.symmetric(horizontal: 20),
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
                          padding: REdgeInsets.symmetric(horizontal: 20),
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
                        ),*/
                          SizedBox(height: 10),

                          state is CheckoutLoadingState
                              ? CircularProgressIndicator()
                              : SizedBox(
                            width: 207.w,
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: () {}, //cubit.placeOrder,
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
            }else if (state is CheckoutLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CheckoutErrorState) {
              return Center(child: Text(state.error));
            } else {
              return const SizedBox();
            }
          } ),
      ),
    );
  }
}
