import 'package:flutter/material.dart';
import 'package:flutter_movie_app/pages/splash/splash_viewmodel.dart';
import 'package:flutter_movie_app/utils/app_routes.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> implements SplashViewModel {
  late SplashViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = this;
    vm.init();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void init() {
    Future.delayed(const Duration(seconds: 3)).then(
          (value) => Get.toNamed(AppRoutes.main),
    );
  }
}
