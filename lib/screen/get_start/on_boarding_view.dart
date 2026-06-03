import 'package:flutter/material.dart';
import 'package:fod_app/helper/my_navigator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/color.dart';
import 'launch_view.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController controller = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  isLast = (index == 2);
                });
              },
              children: [
                buildPage(
                  image: "assets/image/1 (1).png",
                  title: "Order for Food!",
                  desc:
                      "El Banna Group is one of the largest family investments in Egypt and The Middle East with its headquarters located in 10th Of Ramadan City, Egypt.",
                  icon: Icons.transfer_within_a_station_rounded,
                ),
                buildPage(
                  image: "assets/image/1 (1).png",
                  title: "Easy Payment",
                  desc:
                      "El Banna Group was originally established in 1974 and initially specialized in poultry investment.",
                  icon: Icons.card_membership,
                ),
                buildPage(
                  image: "assets/image/Elbanna3.jpg",
                  title: "Fast Delivery",
                  desc:
                      "Today, El Banna Group has been expanding its network across Egypt in more than seven industries: poultry, citrus exports, electricity distribution, pharmaceutical products, paper and cardboard manufacturing, and land reclamation.",
                  icon: Icons.delivery_dining_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage({
    required String image,
    required String title,
    required String desc,
    required IconData? icon,
  }) {
    return SafeArea(
      child: Stack(
        children: [
          Image.asset(image, height: 855.h, width: 393.w, fit: BoxFit.fill),
          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    MyNavigator.goto(
                      context,
                      LaunchView(),
                      type: NavigatorType.pushAndRemoveUntil,
                    );
                  },
                  child: Row(
                    children: [
                      const Text(
                        "Skip",
                        style: TextStyle(color: AppColor.primary),
                      ),
                      Icon( Icons.chevron_right),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 321.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22.r),
                  topRight: Radius.circular(22.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Icon(icon, color: AppColor.primary),
                  SizedBox(height: 20.h),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w900,
                      color: Color(0xffE95322),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 21.h),
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      dotHeight: 5,
                      dotWidth: 5,
                      dotColor: Color(0xffF3E9B5),
                      activeDotColor: AppColor.primary,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ElevatedButton(
                    onPressed: () {
                      if (isLast) {
                        MyNavigator.goto(
                          context,
                          LaunchView(),
                          type: NavigatorType.pushAndRemoveUntil,
                        );
                      } else {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(isLast ? "Start" : "Next"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
