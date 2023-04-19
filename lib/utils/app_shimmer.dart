import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? padding;

  const AppShimmer({Key? key, this.height, this.width, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      padding: EdgeInsets.all(padding ?? 10),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.white.withOpacity(0.6),
          child: const SizedBox()),
    );
  }
}
