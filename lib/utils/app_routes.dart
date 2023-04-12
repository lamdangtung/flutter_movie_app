import 'package:flutter_movie_app/pages/home/home_page.dart';
import 'package:flutter_movie_app/pages/splash/splash_page.dart';
import 'package:get/route_manager.dart';

abstract class AppRoutes {
  static const home = "/home";
  static const splash = "/splash";

  static final pages = [
    GetPage(
      name: home,
      page: () => HomePage(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: Duration(milliseconds: 200),
    ),
    GetPage(
      name: splash,
      page: () => SplashPage(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: Duration(milliseconds: 200),
    )
  ];
}
