import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/repositories/api/app_api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_movie_app/utils/app_shadows.dart';
import 'package:flutter_movie_app/utils/app_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class UpcomingMovieItem extends StatelessWidget {
  final String backgroundImage;

  const UpcomingMovieItem({
    super.key,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      height: 220.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: AppApi.baseImageURL + backgroundImage,
              progressIndicatorBuilder: (context, url, progress) {
                return Center(
                  child: CircularProgressIndicator(value: progress.progress),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
