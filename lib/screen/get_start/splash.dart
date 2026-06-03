import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fod_app/core/utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home-view/views/home_view.dart';
import 'on_boarding_view.dart';
import 'launch_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    _animationController.forward();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    final prefs = await SharedPreferences.getInstance();

    final bool isAppFirstOpen =
        prefs.getBool('first_open') ?? true;

    final String? token = prefs.getString('access_token');
    final bool isFirstLogin =
        prefs.getBool('first_login') ?? true;

    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    if (isAppFirstOpen) {
      await prefs.setBool('first_open', false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnBoardingView()),
      );
      return;
    }

    if (token == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LaunchView()),
      );
      return;
    }

    if (isFirstLogin) {
      await prefs.setBool('first_login', false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>HomeView()),
      );
    } else {//is login and restart
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeView()),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Image.asset(
                "assets/image/logonanotech.png",
                width: 400.w,
                height: 300.h,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Nano",
                    style: TextStyle(
                      color:AppColor.primary,
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
          ],
        ),
      ),
    );
  }
}
