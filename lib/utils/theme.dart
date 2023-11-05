import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khanbuyer_new_design/utils/consts.dart';

ThemeData lightTheme(context) {
  final theme = ThemeData.light();
  final textTheme = theme.textTheme.apply(
    fontFamily: GoogleFonts.getFont('Poppins').fontFamily,
    bodyColor: CColors.text,
  );
  final bottomNavigationBarThemeData = theme.bottomNavigationBarTheme.copyWith(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: Colors.white,
    elevation: 0.0,
    type: BottomNavigationBarType.fixed,
  );
  final snackBarTheme = SnackBarThemeData(
    backgroundColor: CColors.snackBar,
    actionTextColor: Colors.white,
    disabledActionTextColor: CColors.grey,
    contentTextStyle: TextStyle(fontSize: 16.sp),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r))),
    behavior: SnackBarBehavior.floating,
  );
  // Container(
  //       decoration: BoxDecoration(
  //         boxShadow: <BoxShadow>[
  //           BoxShadow(
  //             color: Colors.black,
  //             blurRadius: 10,
  //           ),
  //         ],
  //       ),
  //       child:

  final buttonThemeData = theme.buttonTheme.copyWith(
      buttonColor: CColors.blue,
      disabledColor: CColors.disabledButton,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)));

  // final bottomSheetThemeData = BottomSheetThemeData(
  //   backgroundColor: Colors.white,
  //   shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //     bottom: Radius.circular(16.r),
  //     top: Radius.circular(16.r),
  //   )),
  // );

  // final appBarThemeData = theme.appBarTheme.copyWith(
  //     backgroundColor: Palette.blueRibbon,
  //     titleTextStyle: TextStyle(fontSize: 16.sp),
  //     elevation: 0,
  //     systemOverlayStyle: SystemUiOverlayStyle.light);

  // final bottomAppBarThemeData = theme.bottomAppBarTheme.copyWith(
  //   color: Palette.blueRibbon,
  // );
  // final tabBarThemeData = theme.tabBarTheme.copyWith(
  //     unselectedLabelColor: Palette.cobalt,
  //     indicator: UnderlineTabIndicator(
  //       borderSide: BorderSide(color: Colors.white, width: 3.w),
  //     ));
  // final listTileThemeData = theme.listTileTheme.copyWith(
  //     iconColor: Colors.black,
  //     contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
  //     dense: true);

  // final checkboxThemeData = theme.checkboxTheme.copyWith(
  //   checkColor: MaterialStateProperty.all(Palette.blueRibbon),
  // );

  return theme.copyWith(
    primaryColor: CColors.blue,
    scaffoldBackgroundColor: Colors.white,
    snackBarTheme: snackBarTheme,
    // inputDecorationTheme: InputDecorationTheme(
    //   contentPadding: const EdgeInsets.all(8),
    //   hintStyle: TextStyle(
    //       fontSize: 16.sp,
    //       fontWeight: FontWeight.w400,
    //       color: Palette.santasGray),
    //   border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(6.r),
    //       borderSide: const BorderSide(color: Palette.mischka)),
    //   enabledBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(6.r),
    //       borderSide: const BorderSide(color: Palette.mischka)),
    //   focusedBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(6.r),
    //       borderSide: const BorderSide(color: Palette.mischka)),
    //   disabledBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(6.r),
    //       borderSide: const BorderSide(color: Palette.mischka)),
    // ),
    // bottomAppBarTheme: bottomAppBarThemeData,
    buttonTheme: buttonThemeData,
    textTheme: textTheme,
    // tabBarTheme: tabBarThemeData,
    bottomNavigationBarTheme: bottomNavigationBarThemeData,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 20.w)),
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.disabled)
                  ? CColors.disabledButton
                  : CColors.blue,
            ),
            textStyle: MaterialStateProperty.resolveWith(
              (states) => textTheme.bodyText2!.copyWith(
                fontSize: 16.sp,
                fontFamily: GoogleFonts.getFont('DM Sans').fontFamily,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            fixedSize: MaterialStateProperty.all(
              Size(
                double.infinity,
                47.h,
              ),
            ),
            // backgroundColor: MaterialStateProperty.resolveWith((states) {
            //   if (states.contains(MaterialState.disabled)) {
            //     return Palette.athensGray2;
            //   } else {
            //     return Palette.blueRibbon;
            //   }
            // }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r))))),
    // bottomSheetTheme: bottomSheetThemeData,
    // cardColor: Palette.athensGray2,
    // scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    // listTileTheme: listTileThemeData,
    // checkboxTheme: checkboxThemeData,
    // primaryColorLight: Colors.orange,
    // appBarTheme: appBarThemeData
  );
}
