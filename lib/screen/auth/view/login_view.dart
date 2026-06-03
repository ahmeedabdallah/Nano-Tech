import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fod_app/core/utils/color.dart';
import 'package:fod_app/helper/my_navigator.dart';
import 'package:fod_app/screen/auth/cubit/login_cubit/login_cubit.dart';
import '../../../../core/wedgit/main_wedgit.dart';
import '../../../core/helper/app_popup.dart';
import '../../get_start/launch_view.dart';
import '../../home-view/views/home_view.dart';
import '../cubit/login_cubit/login_state.dart';
import '../wedgit/text_form_filed.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: MainWidget(
        appBarTitle: 'Hello!',
        childMainContainer: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              SnackBarPopUp().show(
                context: context,
                message: state.error,
                state: PopUpState.error,
              );
            } else if (state is LoginSuccessState) {
              SnackBarPopUp().show(
                context: context,
                message: 'Logined successfully\nWelcome ${state.user.name}',
                state: PopUpState.success,
              );
              MyNavigator.goto(
                context,
                HomeView(),
                type: NavigatorType.pushReplacement,
              );
            }
          },
          builder: (context, state) {
            var cubit = LoginCubit.get(context);
            return Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: (TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    )),
                  ),
                  SizedBox(height: 32.h),
                  TextFormFiledAuth(
                    controller: cubit.email,
                    titleTextForm: 'Email',
                    hintText: 'Enter email here',
                  ),
                  SizedBox(height: 22.h),
                  TextFormFiledAuth(
                    controller: cubit.password,
                    titleTextForm: 'Password ',
                    hintText: 'Enter Password  here',
                    suffix: IconButton(
                      alignment: Alignment.center,
                      onPressed: () {cubit.changePasswordSecure();},
                      icon: Icon(Icons.visibility, color: AppColor.primary),
                    ),
                    obscure: cubit.passwordSecure,
                  ),
                  SizedBox(height: 60.h),
                  state is LoginLoadingState
                      ? Center(child: CircularProgressIndicator())
                      : Center(
                          child: SizedBox(
                            width: 207.w,
                            height: 45.h,
                            child: ElevatedButton(
                              onPressed: () {
                                cubit.onLoginPressed();
                              },
                              child: Text('Log In'),
                            ),
                          ),
                        ),
                ],
              ),
            );
          },
        ),goBack: () => MyNavigator.goto(
        context,
        LaunchView(),
      ),
      ),
    );
  }
}
