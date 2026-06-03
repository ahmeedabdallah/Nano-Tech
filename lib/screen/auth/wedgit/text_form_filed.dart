import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fod_app/core/utils/color.dart';

class TextFormFiledAuth extends StatelessWidget {
  const TextFormFiledAuth({
    super.key,
    required this.titleTextForm,
    this.hintText,
    this.controller,
    this.suffix,
    this.obscure=false
  });
  final String titleTextForm;
  final String? hintText;
  final TextEditingController? controller;
  final IconButton? suffix;
  final bool obscure;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleTextForm,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.black,
          ),
        ),
        Container(
          height: 45.h,
          width: 322.w,
          decoration: BoxDecoration(
            color: AppColor.textFormFiled,
            borderRadius: BorderRadius.circular(13),
          ),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'this failed is required';
              }
              return null;
            },
            obscureText: obscure,
            obscuringCharacter: '*',
            controller: controller,
            decoration: InputDecoration(
              suffix: suffix,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(color: AppColor.greyDark,fontSize:14.sp,fontWeight: FontWeight.w100
              ),

              ),
            ),
          ),
      ],
    );
  }
}
