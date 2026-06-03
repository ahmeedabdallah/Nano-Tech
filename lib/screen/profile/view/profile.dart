import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fod_app/core/utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/my_navigator.dart';
import '../../auth/view/login_view.dart';
import '../../home-view/views/home_view.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("image/GettyImages-1315607788 2.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hallo!'),
                      Text(
                        "Ahmed Abdallah",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  a(
                    name: "profile",
                    icon1: Icon(Icons.person),
                    icon2: Icon(Icons.chevron_right),
                    screen:(){}  ,
                  ),
                  a(
                    name: 'Change Password',
                    icon1: Icon(Icons.lock),
                    icon2: Icon(Icons.chevron_right),
                    screen:(){}  ,
                  ),
                  a(
                    name: 'Settings',
                    icon1: Icon(Icons.settings),
                    icon2: Icon(Icons.chevron_right),
                    screen:(){}  ,
                  ),
                  a(
                    name: 'Home Bage',
                    icon1: Icon(Icons.house_outlined),
                    icon2: Icon(Icons.chevron_right),
                    screen:()=>MyNavigator.goto(context,HomeView())  ,
                  ),
                  a(
                      name: 'Logout',
                      icon1: Icon(Icons.settings),
                      icon2: Icon(Icons.logout_outlined),
                      screen:()async{var pref = await SharedPreferences.getInstance();
                      pref.remove('access_token');
                      pref.remove('refresh_token');
                      MyNavigator.goto(context, LoginView(),
                          type: NavigatorType.pushReplacement);  }
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class a extends StatelessWidget {
  const a({
    super.key,
    required this.name,
    required this.icon1,
    required this.icon2,
    required this.screen,

  });
  final String name;
  final Icon icon1;
  final Icon icon2;
  final void  Function()? screen;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(10),
        height: 63.h,
        width: 331.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColor.backgroundColor,
        ),
        child: Row(
          children: [
            icon1,
            SizedBox(width: 16),
            Text(name),
            Spacer(),
            IconButton(
                icon: icon2,
                onPressed: screen
            ),
          ],
        ),
      ),
    );
  }
}
