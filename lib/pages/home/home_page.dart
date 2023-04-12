import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_movie_app/pages/home/home_viewmodel.dart';
import 'package:flutter_movie_app/utils/app_colors.dart';
import 'package:flutter_movie_app/utils/app_icons.dart';
import 'package:flutter_movie_app/utils/app_images.dart';
import 'package:flutter_movie_app/utils/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomeViewModel {
  late HomeViewModel vm;
  late TextEditingController _searchController;
  late PageController _controller;
  int popularMovieIndex = 0;

  @override
  void initState() {
    super.initState();
    vm = this;
    vm.init();
    _searchController = TextEditingController();
    _controller =
        PageController(viewportFraction: 0.75, initialPage: popularMovieIndex);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24.h,
        ),
        _buildGreeting(),
        SizedBox(
          height: 20.h,
        ),
        _buildSearch(),
        SizedBox(
          height: 24.h,
        ),
        _buildMostPopular()
      ],
    );
  }

  Column _buildMostPopular() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            "Most Popular",
            style: AppTextStyles.baseTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        _buildPopularMovies(),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCategoryItem(AppIcons.icCategory, "Genres"),
                _buildCategoryItem(AppIcons.icTvSeries, "TV series"),
                _buildCategoryItem(AppIcons.icMovieRoll, "Movies"),
                _buildCategoryItem(AppIcons.icCinema, "In Theatre"),
              ],
            ),
          ),
        )
      ],
    );
  }

  Container _buildCategoryItem(String icon, String title) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: AppColors.backgroundGradient),
      height: 95.h,
      width: 70.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 42.w,
            height: 42.h,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            title,
            style: AppTextStyles.baseTextStyle.copyWith(
                fontSize: 9, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Column _buildPopularMovies() {
    return Column(
      children: [
        SizedBox(
          height: 160.h,
          width: double.infinity,
          child: PageView.builder(
            itemCount: 50,
            onPageChanged: (index) {
              setState(() {
                popularMovieIndex = index;
              });
            },
            controller: _controller,
            itemBuilder: (_, index) => Container(
              margin: const EdgeInsets.all(10),
              height: 160.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      offset: const Offset(4, 4),
                      blurRadius: 15,
                      spreadRadius: 0)
                ],
              ),
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Image.asset(
                      AppImages.imgBackground,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    left: 26.w,
                    bottom: 15.h,
                    child: Text(
                      "DeadPool 2",
                      style: AppTextStyles.baseTextStyle.copyWith(
                          fontSize: 18.r,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                  Positioned(
                    right: 26.w,
                    bottom: 20.h,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      height: 14.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: const Color(0xFFF5C518),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.icImdb,
                            width: 14.w,
                            height: 5.h,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            "8.5",
                            style: AppTextStyles.baseTextStyle.copyWith(
                                fontSize: ScreenUtil().setSp(6),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        _buildPageIndicator(popularMovieIndex % 3),
      ],
    );
  }

  SizedBox _buildPageIndicator(int activeIndex) {
    return SizedBox(
      height: 10.h,
      child: Center(
        child: ListView.builder(
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: SizedBox(
                height: 8,
                width: 8,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: activeIndex == index
                          ? AppColors.secondaryGradient
                          : AppColors.secondaryGradient30),
                ),
              ),
            );
          },
          itemCount: 3,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Padding _buildSearch() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: TextFormField(
        style: AppTextStyles.baseTextStyle.copyWith(
            fontSize: 18.sp, fontWeight: FontWeight.w400, color: Colors.white),
        controller: _searchController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          prefixIcon: Padding(
            padding: EdgeInsets.all(12.r),
            child: SvgPicture.asset(
              AppIcons.icSearch,
              width: 22.w,
              height: 22.h,
              color: Colors.white,
              fit: BoxFit.contain,
            ),
          ),
          hintStyle: AppTextStyles.baseTextStyle.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.2)),
          hintText: "Search",
          suffixIcon: Padding(
            padding: EdgeInsets.only(bottom: 12.h, top: 12.h),
            child: SvgPicture.asset(
              AppIcons.icMic,
              width: 16.w,
              height: 2.h,
              color: Colors.white,
              fit: BoxFit.contain,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.r),
            borderSide:
                BorderSide(color: Colors.white.withOpacity(0.2), width: 1.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.r),
            borderSide:
                BorderSide(color: Colors.white.withOpacity(0.2), width: 1.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.r),
            borderSide:
                BorderSide(color: Colors.white.withOpacity(0.2), width: 1.r),
          ),
        ),
      ),
    );
  }

  Padding _buildGreeting() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 64.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: "Hello, ",
                    style: AppTextStyles.baseTextStyle.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
                TextSpan(
                    text: "Jane!",
                    style: AppTextStyles.baseTextStyle.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
          ),
          SvgPicture.asset(
            AppIcons.icNotification,
            width: 24.w,
            height: 24.h,
          ),
        ],
      ),
    );
  }

  @override
  void init() {}
}
