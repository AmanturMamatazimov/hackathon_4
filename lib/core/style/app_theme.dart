import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';


  ThemeData themeData = ThemeData(
    primaryColor: AppColors.mainColor,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: Colors.white,
      // elevation: 2,
      titleTextStyle: AppTextStyles.black18Semibold.copyWith(fontSize: 16.sp),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppColors.mainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        // maximumSize: Size(345, 50),
        padding: const EdgeInsets.symmetric(
          horizontal: 140,
          vertical: 15,
        ),
        elevation: 0,
        // splashFactory: InteractiveInkFeature()
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      // constraints: BoxConstraints(
      //   maxHeight: 50,
      //   minHeight: 49,
      // ),
      contentPadding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
    ),
    textTheme: TextTheme(
      headline1: AppTextStyles.black20Bold,
      headline2:
          AppTextStyles.black20Bold.copyWith(fontWeight: FontWeight.w600),
      headline6: AppTextStyles.black16Medium,
    ),
  );
