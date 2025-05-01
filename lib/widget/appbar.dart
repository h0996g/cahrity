import 'package:charity/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBarFirst extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarFirst({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: GestureDetector(
        onTap: () {},
        child: SvgPicture.asset(
          'assets/icons/logo.svg',
          //  cacheHeight: 129,
          fit: BoxFit.cover,
          height: 50,
          // width: 100,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBarSecond extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? title;

  const CustomAppBarSecond({super.key, this.leading, this.actions, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: primaryColor,
      leading:
          leading ??
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25.sp),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
      actions: actions,
      title: title,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
