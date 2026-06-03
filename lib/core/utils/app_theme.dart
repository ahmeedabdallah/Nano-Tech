import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color.dart';

class AppTheme {

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.backgroundColor,
    primaryColor: AppColor.primary,
    fontFamily: 'Cairo',

    iconTheme: const IconThemeData(
      color: AppColor.black,
      size: 24,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColor.black),
      titleTextStyle: TextStyle(
        color: AppColor.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColor.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColor.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.6,
        color: AppColor.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColor.greyDark,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColor.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColor.primary,
      onPrimary: AppColor.black,
      onSurface: AppColor.backgroundColor,
      surface: AppColor.white,
      //secondary: AppColor.secondary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.textFormFiled,
      contentPadding:  REdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
          ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColor.grey, width: 1),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColor.primary, width: 2),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColor.grey, width: 1),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColor.error, width: 1.5),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.primary,
      foregroundColor: AppColor.white,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColor.white,
      selectedItemColor: AppColor.black,
      unselectedItemColor: AppColor.grey,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColor.darkBackground,
    primaryColor: AppColor.primary,
    fontFamily: 'Cairo',

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.darkBackground,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColor.white),
      titleTextStyle: TextStyle(
        color: AppColor.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColor.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColor.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.6,
        color: AppColor.greyLight,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColor.grey,
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColor.white,
      size: 24,
    ),

  colorScheme: ColorScheme.dark(
  primary: AppColor.primary,
  onSurface: AppColor.darkBackground,
  surface: AppColor.darkSurface,
  ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.darkSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
