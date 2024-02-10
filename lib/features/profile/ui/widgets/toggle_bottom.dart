import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleButton extends StatelessWidget {
  const ToggleButton(
      {super.key,
      required this.width,
      required this.enumTap,
      required this.text,
      required this.onTap,
        required this.activeTap});

  final double width;
  final ProfileTabsEnum enumTap;
  final String text;
  final Function() onTap;
  final ProfileTabsEnum activeTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: enumTap == activeTap
              ? AppColors.primary
              : AppColors.black_222232,
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppFonts.font20w600WithColor(enumTap == activeTap
                ? AppColors.black_222232
                : AppColors.grey_B4B4B4),
          ),
        ),
      ),
    );
  }
}
