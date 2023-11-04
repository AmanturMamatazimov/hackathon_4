import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle whiteBold =
      TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
  static const TextStyle blackText = TextStyle(
      color: AppColors.customText, fontWeight: FontWeight.w600, fontSize: 18);
  static const TextStyle black12 = TextStyle(
      color: AppColors.customText, fontWeight: FontWeight.w500, fontSize: 12);
  static const TextStyle black16 = TextStyle(
      color: AppColors.customText, fontWeight: FontWeight.w500, fontSize: 16);
  static const TextStyle custom20 = TextStyle(
      color: AppColors.customText, fontWeight: FontWeight.w500, fontSize: 20);
  static const TextStyle custom18 = TextStyle(
      color: AppColors.customText, fontWeight: FontWeight.w500, fontSize: 18);
  static const TextStyle custom14 = TextStyle(
      color: AppColors.customText, fontWeight: FontWeight.w500, fontSize: 14);
  static const TextStyle black14 = TextStyle(fontSize: 14, color: Colors.black);
  static const TextStyle custom15 = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.customButton);
  static const TextStyle black15 = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.customText);

  static const TextStyle black26 = TextStyle(fontSize: 26);
  static const TextStyle black20 = TextStyle(fontSize: 20);

  static TextStyle black16Regular = TextStyle(
    fontSize: 16.sp,
    fontFamily: 'Gilroy',
    height: 1.5,
    color: AppColors.mainBlack,
  );

  static TextStyle black14Medium = TextStyle(
    fontSize: 14.sp,
    fontFamily: 'Gilroy',
    height: 1.18,
    fontWeight: FontWeight.w500,
    color: AppColors.mainBlack,
  );

  static TextStyle black18Semibold = TextStyle(
    fontSize: 18.sp,
    fontFamily: 'Gilroy',
    height: 1.19,
    fontWeight: FontWeight.w600,
    color: AppColors.mainBlack,
  );

  static TextStyle orange14Semibold = TextStyle(
    fontSize: 14.sp,
    fontFamily: 'Gilroy',
    height: 1.19,
    fontWeight: FontWeight.w600,
    color: AppColors.mainColor,
  );

  static TextStyle white16Bold = TextStyle(
    fontSize: 16.sp,
    fontFamily: 'Gilroy',
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static TextStyle black20Bold = TextStyle(
    fontSize: 20.sp,
    fontFamily: 'Gilroy',
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: AppColors.mainBlack,
  );

  static TextStyle black16Medium = TextStyle(
    fontSize: 16.sp,
    fontFamily: 'Gilroy',
    height: 1.2,
    fontWeight: FontWeight.w500,
    color: AppColors.mainBlack,
  );
}
