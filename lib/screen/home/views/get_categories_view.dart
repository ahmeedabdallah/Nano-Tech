import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fod_app/core/utils/color.dart';
import '../../../core/helper/app_navigator.dart';
import '../../cart/views/cart_view.dart';
import '../../item/cubit/Item_cubit/Item_cubit.dart';
import '../../item/data/models/product_item_model.dart';
import '../../item/views/item_view.dart';
import '../cubit/get_categories_cubit/get_categories_cubit.dart';
import '../cubit/get_categories_cubit/get_categories_state.dart';

class GetCategoriesView extends StatelessWidget {
  const GetCategoriesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => GetCategoriesCubit()..getCategories(),
          child: BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
            builder: (context, state) {
              if (state is GetCategoriesSuccessState ||
                  state is GetCategoriesInedxChangedState) {
                var cubit = GetCategoriesCubit.get(context);
                return Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.12,
                      decoration: BoxDecoration(
                        color: AppColor.backgroundColor,
                      ),
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
                            topRight: Radius.circular(30.r),
                            topLeft: Radius.circular(30.r),
                          ),
                        ),
                        child: Column(
                          children: [
                            // categories
                            SizedBox(
                              height: 80.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap: () => cubit.selectCategory(index),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: REdgeInsets.only(right: 12),
                                            width: 90.w,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              child: Image.network(
                                                cubit
                                                        .categories[index]
                                                        .imagePath ??
                                                    '',
                                                width: 75.w,
                                                height: 50.h,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            cubit.categories[index].title ?? '',
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 20),
                                itemCount: cubit.categories.length,
                              ),
                            ),
                            SizedBox(height: 20),

                            // products for selected category
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ItemView(),
                                      ),
                                    );
                                    ItemCubit.get(context).addProductToItem(
                                      ProductItemModel(
                                        itemModel:
                                            GetCategoriesCubit.get(context)
                                                .categories[cubit
                                                    .selectedCategoryIndex]
                                                .products![index],
                                        quantity: 1,
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: REdgeInsets.symmetric(
                                          horizontal: 30,
                                        ),
                                        width: double.infinity,
                                        height: 0.5,
                                        color: AppColor.backgroundColor,
                                      ),
                                      Container(
                                        height: 174.h,
                                        width: double.infinity,
                                        padding: REdgeInsets.all(19),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            36.r,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            36.r,
                                          ),
                                          child: Image.network(
                                            cubit
                                                    .categories[cubit
                                                        .selectedCategoryIndex]
                                                    .products?[index]
                                                    .imagePath ??
                                                '',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: REdgeInsets.symmetric(
                                          horizontal: 18.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              cubit
                                                      .categories[cubit
                                                          .selectedCategoryIndex]
                                                      .products?[index]
                                                      .name ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.black,
                                              ),
                                            ),
                                            SizedBox(width: 11.w),

                                            Icon(
                                              Icons.circle,
                                              color: AppColor.primary,
                                              size: 6,
                                            ),
                                            SizedBox(width: 11.w),
                                            Container(
                                              width: 34.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: AppColor.primary,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${cubit.categories[cubit.selectedCategoryIndex].products?[index].rating}',
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: AppColor.white,
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

                                            SizedBox(width: 103.w),
                                            Text(
                                              '\$${cubit.categories[cubit.selectedCategoryIndex].products?[index].price}',
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: REdgeInsets.symmetric(
                                          horizontal: 18.0,
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            cubit
                                                    .categories[cubit
                                                        .selectedCategoryIndex]
                                                    .products?[index]
                                                    .description ??
                                                '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w300,
                                              color: AppColor.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 20),
                                itemCount:
                                    cubit
                                        .categories[cubit.selectedCategoryIndex]
                                        .products
                                        ?.length ??
                                    0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is GetCategoriesLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetCategoriesErrorState) {
                return Center(child: Text(state.error));
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
