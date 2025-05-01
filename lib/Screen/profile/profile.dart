import 'package:charity/Screen/Login/componants/components.dart';
import 'package:charity/const/const.dart';
import 'package:charity/const/size_text.dart';
import 'package:charity/helper/cach.dart';
import 'package:charity/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal.w,
          vertical: paddingVertical.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSubmitButton(
              text: 'Logout',
              onPressed: () {
                CachHelper.removdata(key: tokenCache);
                context.go(RouteConstants.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
