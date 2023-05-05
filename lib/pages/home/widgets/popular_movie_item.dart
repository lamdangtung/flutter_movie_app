import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/repositories/api/app_api.dart';
import 'package:flutter_movie_app/utils/app_icons.dart';
import 'package:flutter_movie_app/utils/app_images.dart';
import 'package:flutter_movie_app/utils/app_shadows.dart';
import 'package:flutter_movie_app/utils/app_shimmer.dart';
import 'package:flutter_movie_app/utils/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PopularMovieItem extends StatelessWidget {
  final String movieName;
  final String imdbRating;
  final String backgroundImage;

  const PopularMovieItem({
    super.key,
    required this.movieName,
    required this.imdbRating,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      height: 160.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: AppApi.baseImageURL + backgroundImage,
              progressIndicatorBuilder: (context, url, progress) {
                return Center(
                  child: CircularProgressIndicator(value: progress.progress),
                );
              },
            ),
          ),
          Positioned(
            left: 26.w,
            bottom: 15.h,
            child: SizedBox(
              width: 200.w,
              child: Text(
                movieName,
                style: AppTextStyles.baseTextStyle
                    .copyWith(fontSize: 18.r, fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            right: 26.w,
            bottom: 20.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
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
                    imdbRating,
                    style: AppTextStyles.baseTextStyle
                        .copyWith(fontSize: ScreenUtil().setSp(6), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
