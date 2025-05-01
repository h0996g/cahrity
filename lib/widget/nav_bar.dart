import 'package:charity/const/colors.dart';
import 'package:charity/Screen/Families/cubit/family_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonNavBar extends StatelessWidget {
  final Function(int) onTap;

  const ButtonNavBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FamilyCubit, FamilyState>(
      buildWhen: (previous, current) => current is HomeChangeIndex,
      builder: (context, state) {
        final selectedIndex = FamilyCubit.get(context).selectBottomindex;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SalomonBottomBar(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            itemPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            currentIndex: selectedIndex,
            onTap: (index) {
              onTap(index);
            },
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: const Icon(Icons.home_outlined, size: 24),
                title: Text(
                  AppLocalizations.of(context)!.home,
                  style: const TextStyle(fontSize: 14),
                ),
                selectedColor: primaryColor,
                unselectedColor: Colors.grey[600],
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: const Icon(Icons.add, size: 24),
                title: Text('Add', style: const TextStyle(fontSize: 14)),
                selectedColor: primaryColor,
                unselectedColor: Colors.grey[600],
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: const Icon(Icons.person_outline, size: 24),
                title: Text(
                  AppLocalizations.of(context)!.account,
                  style: const TextStyle(fontSize: 14),
                ),
                selectedColor: primaryColor,
                unselectedColor: Colors.grey[600],
              ),
            ],
          ),
        );
      },
    );
  }
}
