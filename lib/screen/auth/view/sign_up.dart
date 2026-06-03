import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fod_app/screen/auth/view/login_view.dart';
import '../../../core/helper/app_popup.dart';
import '../../../core/utils/color.dart';
import '../../../core/wedgit/main_wedgit.dart';
import '../../../helper/my_navigator.dart';
import '../../get_start/launch_view.dart';
import '../cubit/register_cubit/SignUP_cubit.dart';
import '../cubit/register_cubit/register_state.dart';
import '../wedgit/text_form_filed.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: MainWidget(
        appBarTitle: 'New Account!',
        childMainContainer: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterErrorState) {
              SnackBarPopUp().show(
                context: context,
                message: state.error,
                state: PopUpState.error,
              );
            } else if (state is RegisterSuccessState) {
              SnackBarPopUp().show(
                context: context,
                message: 'Sign Up successfully\nLogin Now ${state.user.name}',
                state: PopUpState.success,
              );
              MyNavigator.goto(
                context,
                LoginView(),
                type: NavigatorType.pushReplacement,
              );
            }
          },
          builder: (context, state) {
            var cubit = RegisterCubit.get(context);
            return Form(
              key: cubit.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormFiledAuth(
                      controller: cubit.fullName,
                      titleTextForm: 'Full name ',
                      hintText: 'Enter Full name here',
                    ),
                    SizedBox(height: 10.h),
                    TextFormFiledAuth(
                      controller: cubit.email,
                      titleTextForm: 'Email',
                      hintText: 'Enter email here',
                    ),
                    SizedBox(height: 10.h),
                    TextFormFiledAuth(
                      controller: cubit.mobileNumber,
                      titleTextForm: 'Mobile Number',
                      hintText: 'Enter Mobile Number here',
                    ),
                    SizedBox(height: 10.h),
                    TextFormFiledAuth(
                      controller: cubit.password,
                      titleTextForm: 'Password ',
                      hintText: 'Enter Password here',
                      suffix: IconButton(
                        alignment: Alignment.center,
                        onPressed: () {cubit.changePasswordSecure();},
                        icon: Icon(Icons.visibility, color: AppColor.primary),
                      ),
                      obscure:cubit.passwordSecure,
                    ),
                    SizedBox(height: 10.h),
                    TextFormFiledAuth(
                      controller: cubit.confirmPassword,
                      titleTextForm: 'Confirm Password  ',
                      hintText: 'Confirm Password here',
                      suffix: IconButton(
                        alignment: Alignment.center,
                        onPressed: () =>cubit.changeConfirmPasswordSecure(),
                        icon: Icon(Icons.visibility, color: AppColor.primary),
                      ),
                      obscure: cubit.confirmPasswordSecure,
                    ),
                    SizedBox(height: 31.h),
                    state is RegisterLoadingState
                        ? CircularProgressIndicator()
                        : Center(
                            child: SizedBox(
                              width: 207.w,
                              height: 45.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  cubit.onRegisterPressed();
                                },
                                child: Text('Sign Up'),
                              ),
                            ),
                          ),
                    SizedBox(height: 10.h,),
                    Center(
                      child: Text(
                        'By continuing, you agree to ',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColor.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Terms of Use",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColor.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: " and",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColor.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            TextSpan(
                              text: " Privacy Policy.",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColor.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ), goBack: () => MyNavigator.goto(
        context,
        LaunchView(),
      ),

      ),
    );
  }
}
