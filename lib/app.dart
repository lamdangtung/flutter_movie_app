import 'package:flutter/material.dart';
import 'package:flutter_movie_app/pages/home/home_page.dart';
import 'package:flutter_movie_app/utils/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428,926),
      builder:(context,child) => GetMaterialApp(
        getPages: AppRoutes.pages,
        initialRoute: AppRoutes.splash,
        home: child,
      ),
      child: const HomePage(),
    );
  }
}
