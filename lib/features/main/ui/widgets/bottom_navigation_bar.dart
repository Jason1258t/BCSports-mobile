import 'package:bcsports_mobile/features/main/bloc/cubit/main_cubit.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CustomButtonNavBar extends StatelessWidget {
  const CustomButtonNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: AppColors.black_252525,
        currentIndex: context.read<MainCubit>().currentPageIndex,
        showUnselectedLabels: true,
        unselectedItemColor: AppColors.grey_B4B4B4,
        selectedItemColor: AppColors.yellow_F3D523,
        selectedLabelStyle: AppFonts.font11w300,
        unselectedLabelStyle: AppFonts.font11w300,

        onTap: (newPageIndex) {
          context.read<MainCubit>().changePageIndexTo(newPageIndex);
        },
        items: [
          NavItem(iconPath: Assets.icons('market.svg'), label: "Market"),
          NavItem(iconPath: Assets.icons('ar.svg'), label: "AR"),
          NavItem(iconPath: Assets.icons('photo.svg'), label: "Photo"),
          NavItem(iconPath: Assets.icons('profile.svg'), label: "Profile"),
        ]);
  }
}

class NavItem extends BottomNavigationBarItem {
  final String iconPath;
  final String label;

  NavItem({required this.iconPath, required this.label})
      : super(
            icon: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child:
                    SvgPicture.asset(iconPath, color: AppColors.white_F4F4F4)),
            label: label,
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SvgPicture.asset(
                iconPath,
                color: AppColors.yellow_F3D523,
              ),
            ));
}
