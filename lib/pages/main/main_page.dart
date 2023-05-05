import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie_app/pages/home/home_page.dart';
import 'package:flutter_movie_app/pages/main/main_viewmodel.dart';
import 'package:flutter_movie_app/utils/app_colors.dart';
import 'package:flutter_movie_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> implements MainViewModel {
  int selectedIndex = 0;
  final icons = [AppIcons.icHome, AppIcons.icFavorite, AppIcons.icTicket, AppIcons.icAccount, AppIcons.icShuffle];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: const [
            HomePage(),
            Scaffold(
              backgroundColor: Colors.blue,
            ),
            Scaffold(backgroundColor: Colors.greenAccent),
            Scaffold(backgroundColor: Colors.green),
            Scaffold(backgroundColor: Colors.yellow),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 72.h,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          border: Border(
            top: BorderSide(color: Colors.white.withOpacity(0.2), width: 1.r),
          ),
        ),
        width: double.infinity,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: icons
                .asMap()
                .entries
                .map((e) => _buildNavigationItem(selectedIndex, e.key, () {
                      setState(() {
                        selectedIndex = e.key;
                      });
                    }))
                .toList()),
      ),
    );
  }

  Widget _buildNavigationItem(int activeIndex, int index, VoidCallback onPressed) {
    final isActive = activeIndex == index;
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icons[index],
              width: 32.w,
              height: 32.h,
              color: isActive ? Colors.white : Colors.white.withOpacity(0.2),
            ),
            SizedBox(
              height: 8.h,
            ),
            DecoratedBox(
              decoration: BoxDecoration(shape: BoxShape.circle, color: isActive ? Colors.white : Colors.transparent),
              child: SizedBox(
                height: 8.h,
                width: 8.w,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void init() {}
}
