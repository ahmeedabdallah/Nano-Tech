import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fod_app/core/utils/color.dart';
import '../../../core/wedgit/custom_slider.dart';
import '../../../helper/my_navigator.dart';
import '../../cart/views/cart_view.dart';
import '../../home/views/get_categories_view.dart';
import '../../profile/view/profile.dart';
import '../cubit/home_cubit/home_cubit.dart';
import '../cubit/home_cubit/home_cubit_state.dart';
import '../cubit/home_cubit/slider_cubit.dart';
import '../cubit/home_cubit/slider_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..fetchProducts(),
      child: BlocBuilder<HomeCubit, HomeCubitState>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          DateTime dateTime = DateTime.now();
          String typeOfEat;

          if (dateTime.hour >= 5 && dateTime.hour < 12) {
            typeOfEat = 'breakfast';
          } else if (dateTime.hour >= 12 && dateTime.hour < 18) {
            typeOfEat = 'lunch';
          } else {
            typeOfEat = 'dinner';
          }
          final pages = [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        color: AppColor.backgroundColor,
                      ),
                      width: double.infinity,
                      padding: REdgeInsets.symmetric(horizontal: 35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dateTime.hour < 18 ? 'Good Morning' : 'Good Night',
                            style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 22.sp,
                            ),
                          ),
                          Text(
                            "Rise and shine! It's El Banna Group", //$typeOfEat
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.72,
                    width: double.infinity,
                    padding: REdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.r),
                        topLeft: Radius.circular(30.r),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Best Seller ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.sp,
                                  color: AppColor.black,
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () => MyNavigator.goto(
                                  context,
                                  GetCategoriesView(),
                                ),
                                child: Text(
                                  'View All',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ),
                              Icon(Icons.chevron_right),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            height: 100.h,
                            child: ListView.builder(
                              padding: REdgeInsets.only(left: 6, right: 6),
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit.products.length,
                              itemBuilder: (context, index) => Stack(
                                children: [
                                  Container(
                                    margin: REdgeInsets.only(right: 12),
                                    width: 90.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.r),
                                      child: Image.network(
                                        cubit.products[index].imagePath ?? '',
                                        height: 90.h,
                                        width: 90.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 52.w,
                                    top: 60.h,
                                    child: Container(
                                      height: 18.h,
                                      width: 38.w,
                                      decoration: BoxDecoration(
                                        color: AppColor.primary,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(30),
                                          topLeft: Radius.circular(30),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '\$${cubit.products[index].price}',
                                          style: TextStyle(
                                            color: AppColor.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          BlocProvider(
                            create: (context) => SliderCubit()..fetchSliders(),
                            child: BlocBuilder<SliderCubit, SliderCubitState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    Container(
                                      padding: REdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      height: 128.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withAlpha(25),
                                            blurRadius: 10,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: CustomSlider(
                                        carouselList: List.generate(
                                          SliderCubit.get(
                                            context,
                                          ).sliders.length,
                                          // cubit.newResponse?.articles?.length ?? 0,
                                          (index) => GestureDetector(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      SliderCubit.get(context)
                                                              .sliders[index]
                                                              .imagePath ??
                                                          '',
                                                    ),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        onPageChange: cubit.changeIndexSlider,
                                      ),
                                    ),
                                    FittedBox(
                                      child:
                                          (SliderCubit.get(
                                                context,
                                              ).sliders.length >
                                              0)
                                          ? DotsIndicator(
                                              // dotsCount: count,
                                              dotsCount: SliderCubit.get(
                                                context,
                                              ).sliders.length,
                                              position: cubit.currentIndex
                                                  .toDouble(),
                                              decorator: DotsDecorator(
                                                size: Size(20, 4),
                                                activeSize: Size(20, 4),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                activeShape:
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                    ),
                                                color: AppColor.backgroundColor,
                                                activeColor: Colors.redAccent,
                                              ),
                                            )
                                          : SizedBox(),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),

                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Recommend",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.sp,
                                  color: AppColor.black,
                                ),
                              ),
                            ],
                          ),
                          GridView.builder(
                            shrinkWrap: true,

                            physics: NeverScrollableScrollPhysics(),

                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.2,
                                ),
                            itemCount: cubit.products.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.r),
                                      child: Image.network(
                                        cubit.products[index].imagePath ?? '',
                                        height: 159.h,
                                        width: 175.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 138.w,
                                    top: 130.h,
                                    child: Container(
                                      height: 18.h,
                                      width: 38.w,
                                      decoration: BoxDecoration(
                                        color: AppColor.primary,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(30),
                                          topLeft: Radius.circular(30),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '\$${cubit.products[index].price}',
                                          style: TextStyle(
                                            color: AppColor.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10.w,
                                    top: 10.h,
                                    child: Container(
                                      height: 18.h,
                                      width: 38.w,
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(
                                          30.r,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 5),
                                          Text(
                                            '${cubit.products[index].rating}',
                                            style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Color(0xffF4BA1B),
                                            size: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 55.w,
                                    top: 10.h,
                                    child: CircleAvatar(
                                      radius: 9.r,
                                      backgroundColor: AppColor.white,
                                      child: Icon(
                                        size: 12,
                                        Icons.favorite,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            GetCategoriesView(),
            Profile(),
          ];

          return Scaffold(
            backgroundColor: AppColor.white,
            appBar: AppBar(
              backgroundColor: AppColor.backgroundColor,
              title: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 26.h,
                      width: 250.w,
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: AppColor.white,
                          contentPadding: REdgeInsets.symmetric(vertical: 5),
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 13.w),
                    SizedBox(
                      child: InkWell(
                        onTap: () => MyNavigator.goto(context, CartView()),
                        child: Center(
                          child: CircleAvatar(
                            radius: 18.r,
                            backgroundColor: AppColor.white,
                            child: Icon(
                              Icons.shopping_cart,
                              color: AppColor.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: state is LoadingHome || state is LoadingSlider
                ? const Center(child: CircularProgressIndicator())
                : state is ErrorHome
                ? const Center(
                    child: Text('Error occurred while fetching data'),
                  )
                : Stack(children: [pages[cubit.navIndex]]),
          );
        },
      ),
    );
  }
}
