import 'package:flutter/material.dart';
import 'package:flutter_movie_app/main.dart';
import 'package:flutter_movie_app/models/load_status.dart';
import 'package:flutter_movie_app/models/movie.dart';
import 'package:flutter_movie_app/pages/home/home_viewmodel.dart';
import 'package:flutter_movie_app/pages/home/widgets/popular_movie_item.dart';
import 'package:flutter_movie_app/pages/home/widgets/upcoming_movie_item.dart';
import 'package:flutter_movie_app/repositories/movie_repository.dart';
import 'package:flutter_movie_app/utils/app_colors.dart';
import 'package:flutter_movie_app/utils/app_icons.dart';
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
  late PageController _popularController;
  late PageController _upcomingController;
  LoadStatus loadDataStatus = LoadStatus.initial;
  int popularMovieIndex = 1;
  int upcomingMovieIndex = 1;
  List<Movie> popularMovies = [];
  List<Movie> upcomingMovies = [];
  double currPopularPageValue = 1.0;
  double currUpcomingPageValue = 1.0;

  @override
  void initState() {
    super.initState();
    vm = this;
    vm.init();
    _searchController = TextEditingController();
    _popularController =
        PageController(viewportFraction: 0.85, initialPage: popularMovieIndex);
    _upcomingController =
        PageController(viewportFraction: 0.55, initialPage: upcomingMovieIndex);

    _popularController.addListener(() {
      setState(() {
        currPopularPageValue = _popularController.page!;
      });
    });
    _upcomingController.addListener(() {
      setState(() {
        currUpcomingPageValue = _upcomingController.page!;
      });
    });
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
    if (loadDataStatus == LoadStatus.success) {
      return SingleChildScrollView(
        child: Column(
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
            _buildMostPopular(),
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
            ),
            SizedBox(
              height: 35.h,
            ),
            _buildUpcomingReleases(),
            SizedBox(
              height: 16.h,
            ),
          ],
        ),
      );
    } else if (loadDataStatus == LoadStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 4,
        ),
      );
    } else {
      return const Center(
        child: Text("Error"),
      );
    }
  }

  Widget _buildUpcomingReleases() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            "Upcoming Releases",
            style: AppTextStyles.baseTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 220.h,
          width: double.infinity,
          child: PageView.builder(
            itemCount: upcomingMovies.length,
            onPageChanged: (index) {
              setState(() {
                upcomingMovieIndex = index;
              });
            },
            controller: _upcomingController,
            itemBuilder: (_, index) {
              final height = 220.h;
              Matrix4 mt = Matrix4.identity();
              var lowestScale = 0.8;
              var highestScale = 1.0;
              final diffScale = highestScale - lowestScale;
              if (index == currUpcomingPageValue.floor()) {
                var currScale =
                    highestScale - (currUpcomingPageValue - index) * diffScale;
                var currTrans = height * (1 - currScale) / 2;
                mt = Matrix4.diagonal3Values(1.0, currScale, 1.0)
                  ..setTranslationRaw(0, currTrans, 0);
              } else if (index == currUpcomingPageValue.floor() + 1) {
                var currScale = lowestScale +
                    (currUpcomingPageValue - index + 1) * diffScale;
                var currTrans = height * (1 - currScale) / 2;
                mt = Matrix4.diagonal3Values(1.0, currScale, 1.0)
                  ..setTranslationRaw(0, currTrans, 0);
              } else if (index == currUpcomingPageValue.floor() - 1) {
                var currScale = lowestScale +
                    (currUpcomingPageValue - index - 1) * diffScale;
                var currTrans = height * (1 - currScale) / 2;
                mt = Matrix4.diagonal3Values(1.0, currScale, 1.0)
                  ..setTranslationRaw(0, currTrans, 0);
              } else {
                var currScale = lowestScale;
                var currTrans = height * (1 - currScale) / 2;
                mt = Matrix4.diagonal3Values(1.0, currScale, 1.0)
                  ..setTranslationRaw(0, currTrans, 0);
              }
              final movie = upcomingMovies[index];
              return Transform(
                transform: mt,
                child: UpcomingMovieItem(
                  backgroundImage: movie.backdropPath,
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        _buildPageIndicator(upcomingMovieIndex % 3),
      ],
    );
  }

  Widget _buildMostPopular() {
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
      ],
    );
  }

  Widget _buildCategoryItem(String icon, String title) {
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

  Widget _buildPopularMovies() {
    return Column(
      children: [
        SizedBox(
          height: 160.h,
          width: double.infinity,
          child: PageView.builder(
              itemCount: popularMovies.length,
              onPageChanged: (index) {
                setState(() {
                  popularMovieIndex = index;
                });
              },
              controller: _popularController,
              itemBuilder: (_, index) {
                final height = 160.h;
                Matrix4 mt = Matrix4.identity();
                var lowestScale = 0.8;
                var highestScale = 1.0;
                final diffScale = highestScale - lowestScale;
                if (index == currPopularPageValue.floor()) {
                  var currScale =
                      highestScale - (currPopularPageValue - index) * diffScale;
                  var currTrans = height * (1 - currScale) / 2;
                  mt = Matrix4.diagonal3Values(1.0, currScale, 1.0)
                    ..setTranslationRaw(0, currTrans, 0);
                } else if (index == currPopularPageValue.floor() + 1) {
                  var currScale = lowestScale +
                      (currPopularPageValue - index + 1) * diffScale;
                  var currTrans = height * (1 - currScale) / 2;
                  mt = Matrix4.diagonal3Values(1.0, currScale, 1.0)
                    ..setTranslationRaw(0, currTrans, 0);
                } else if (index == currPopularPageValue.floor() - 1) {
                  var currScale = lowestScale +
                      (currPopularPageValue - index - 1) * diffScale;
                  var currTrans = height * (1 - currScale) / 2;
                  mt = Matrix4.diagonal3Values(1.0, currScale, 1.0)
                    ..setTranslationRaw(0, currTrans, 0);
                } else {
                  var currScale = lowestScale;
                  var currTrans = height * (1 - currScale) / 2;
                  mt = Matrix4.diagonal3Values(1.0, currScale, 1.0)
                    ..setTranslationRaw(0, currTrans, 0);
                }
                final movie = popularMovies[index];
                return Transform(
                  transform: mt,
                  child: PopularMovieItem(
                    movieName: movie.title,
                    imdbRating: movie.voteAverage.toStringAsFixed(1),
                    backgroundImage: movie.backdropPath,
                  ),
                );
              }),
        ),
        const SizedBox(
          height: 15,
        ),
        _buildPageIndicator(popularMovieIndex % 3),
      ],
    );
  }

  Widget _buildPageIndicator(int activeIndex) {
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

  Widget _buildSearch() {
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

  Widget _buildGreeting() {
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
                      color: Colors.white),
                ),
                TextSpan(
                  text: "Jane!",
                  style: AppTextStyles.baseTextStyle.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
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
  Future<void> init() async {
    try {
      setState(() {
        loadDataStatus = LoadStatus.loading;
      });
      final movieRepository = getIt<MovieRepository>();
      popularMovies = await movieRepository.fetchPopularMovies();
      upcomingMovies = await movieRepository.fetchUpcomingMovies();
      setState(() {
        loadDataStatus = LoadStatus.success;
      });
    } catch (e) {
      debugPrint("HomePage/Init: ${e.toString()}");
      setState(() {
        loadDataStatus = LoadStatus.failed;
      });
    }
  }
}
