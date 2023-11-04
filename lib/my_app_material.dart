import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_4/feature/home/bloc/home_bloc.dart';
import 'package:hackathon_4/feature/news/bloc/news_bloc.dart';
import 'package:hackathon_4/feature/splash/bloc/splash_bloc.dart';
import 'package:hackathon_4/feature/splash/screen/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/style/app_theme.dart';
import 'feature/home/selectTabProvider.dart';

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
        builder: (context,widget) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SplashBloc(),
          ),
          BlocProvider(
            create: (context) => HomeBloc(),
          ),
          BlocProvider(
            create: (context) => NewsBloc(),
          ),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SelectTabProvider()),
          ],
          child:  MaterialApp(
            builder: (context,widget){
              ScreenUtil.registerToBuild(context);
              return MediaQuery(
                //Setting font does not change with system font size
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
            debugShowCheckedModeBanner: false,
            title: 'Hackathon_4',
            theme: themeData,
            home: const SplashPage(),
          ),
        ),
      ),
    );
  }
}
