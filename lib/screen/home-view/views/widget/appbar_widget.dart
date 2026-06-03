import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fod_app/helper/my_navigator.dart';
import 'package:fod_app/screen/cart/views/cart_view.dart';
import '../../../../core/utils/color.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            height:26.h,
            width: 282.w,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: REdgeInsets.symmetric(vertical: 5),
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: AppColor.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 13.w,),
          InkWell(
            onTap: ()=>MyNavigator.goto(context, CartView()),
            borderRadius: BorderRadius.circular(20.r),
            child: CircleAvatar(
              radius: 10.r,
              backgroundColor: AppColor.white,
              child: Icon(Icons.shopping_cart, color: AppColor.primary),
            ),
          )


        ],
      ),
    );
  }
}
