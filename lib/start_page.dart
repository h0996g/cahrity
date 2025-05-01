import 'package:charity/Screen/profile/profile.dart';
import 'package:charity/home/add_famely.dart';
import 'package:charity/home/cubit/home_cubit.dart';
import 'package:charity/home/home.dart';
import 'package:charity/widget/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          // appBar: CustomAppBarFirst(),
          body: SafeArea(child: getBody(context)),
          bottomNavigationBar: ButtonNavBar(
            onTap: (index) {
              HomeCubit.get(context).changeIndex(index);
            },
          ),
        );
      },
    );
  }
}

Widget getBody(context) {
  final selectBottomindex = HomeCubit.get(context).selectBottomindex;
  if (selectBottomindex == 0) {
    return HomePage();
  } else if (selectBottomindex == 3) {
    return SizedBox();
  } else if (selectBottomindex == 2) {
    return Profile();
  } else if (selectBottomindex == 1) {
    return AddFamilyPage();
  } else {
    return Center(child: Text('Home'));
  }
}

String titleAppBar(index) {
  if (index == 0) {
    return 'Home';
  } else if (index == 1) {
    return 'Categories';
  } else if (index == 2) {
    return 'Cart';
  } else if (index == 3) {
    return 'Orders';
  } else if (index == 4) {
    return 'Profile';
  } else {
    return 'Home';
  }
}
