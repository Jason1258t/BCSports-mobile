import 'package:bcsports_mobile/features/main/bloc/cubit/main_cubit.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
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
    final localize = AppLocalizations.of(context)!;
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: AppColors.black_252525,
        currentIndex: context.watch<MainCubit>().currentPageIndex,
        showUnselectedLabels: true,
        unselectedItemColor: AppColors.grey_B4B4B4,
        selectedItemColor: AppColors.primary,
        selectedLabelStyle: AppFonts.font11w300,
        unselectedLabelStyle: AppFonts.font11w300,
        onTap: (newPageIndex) {
          context.read<MainCubit>().changePageIndexTo(newPageIndex);
        },
        items: [
          NavItem(iconPath: Assets.icons('market.svg'), label: localize.market),
          NavItem(iconPath: Assets.icons('ar.svg'), label: localize.ar),
          NavItem(iconPath: Assets.icons('photo.svg'), label: localize.photo),
          NavItem(iconPath: Assets.icons('profile.svg'), label: localize.profile),
        ]);
  }
}

class NavItem extends BottomNavigationBarItem {
  final String iconPath;

  NavItem({required this.iconPath, super.label})
      : super(
            icon: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child:
                    SvgPicture.asset(iconPath, color: AppColors.white_F4F4F4)),
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SvgPicture.asset(
                iconPath,
                color: AppColors.primary,
              ),
            ));
}
