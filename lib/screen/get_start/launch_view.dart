import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fod_app/helper/my_navigator.dart';
import 'package:fod_app/main.dart';
import 'package:fod_app/screen/home-view/views/home_view.dart';
import '../../core/utils/color.dart';
import '../auth/view/login_view.dart';
import '../auth/view/sign_up.dart';

class LaunchView extends StatelessWidget {
  const LaunchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/image/logonanotech.png",
              width: 200.w,
              height: 300.h,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Nano",
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: 34.85.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(
                    text: " Tech",
                    style: TextStyle(
                      color: AppColor.backgroundColor,
                      fontSize: 34.85.sp,
                      fontWeight: FontWeight.w800,
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding:  REdgeInsets.symmetric(horizontal: 46),
              child: Text(
                'Technology at Your Fingertips.',
                softWrap: true,
                overflow: TextOverflow.visible,
                style: TextStyle(color: AppColor.backgroundColor,fontSize: 14.sp,fontWeight:FontWeight.w500 ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 43.h),
            SizedBox(
              width: 207.w,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  MyNavigator.goto(context, LoginView());
                },
                child: Text(
                  'Log In',
                  style: TextStyle(color: AppColor.primary),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.backgroundColor,)
              ),
            ),
            SizedBox(height: 8.h),

            SizedBox(
              width: 207.w,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () { MyNavigator.goto(context, SignUp());},
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: AppColor.backgroundColor),
                ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary
                  )
              ),
            ),
            SizedBox(height: 30,),
            TextButton(onPressed: (){MyNavigator.goto(context,HomeView());}, child: Text('Skip'))
          ],
        ),
      ),
    );
  }
}
