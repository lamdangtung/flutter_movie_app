import 'package:flutter_movie_app/pages/home/home_page.dart';
import 'package:flutter_movie_app/pages/main/main_page.dart';
import 'package:flutter_movie_app/pages/movie/movie_page.dart';
import 'package:flutter_movie_app/pages/splash/splash_page.dart';
import 'package:get/route_manager.dart';

abstract class AppRoutes {
  static const home = "/home";
  static const splash = "/splash";
  static const main = "/main";
  static const movie = "/movie";

  static final pages = [
    GetPage(
      name: movie,
      page: () => const MoviePage(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: home,
      page: () => const HomePage(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: splash,
      page: () => const SplashPage(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: main,
      page: () => const MainPage(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 200),
    ),
  ];
}
