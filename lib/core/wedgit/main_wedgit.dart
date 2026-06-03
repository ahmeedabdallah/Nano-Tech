import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fod_app/core/utils/color.dart';
import 'package:fod_app/helper/my_navigator.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({
    super.key,
    required this.appBarTitle,
    required this.childMainContainer,
    this.goBack,
  });
  final String appBarTitle;
  final Widget? childMainContainer;
  final VoidCallback? goBack;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundColor,
        leading:
        goBack == null
            ? null
            : IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: AppColor.primary,
          ),
          onPressed: goBack,
        ),
        title: Text(
          appBarTitle,
          style: TextStyle(
            color: AppColor.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body:
            Column(
              children: [
                SizedBox(height: 70.h,),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: REdgeInsets.all(36),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.r),
                        topLeft: Radius.circular(30.r),
                      ),
                    ),
                    child:SingleChildScrollView(

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: childMainContainer,
                      ),
                  ),
                ),

                      ),
              ],
            ),
    );
  }
}
