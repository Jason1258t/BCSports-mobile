import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  const ToggleButton(
      {super.key,
      required this.width,
      required this.enumTap1,
      required this.enumTap2,
      required this.text2,
      required this.text1,
      required this.onTap1,
      required this.onTap2,
        required this.activeTap});

  final double width;
  final ProfileTabsEnum enumTap1;
  final ProfileTabsEnum enumTap2;
  final String text1;
  final String text2;
  final Function() onTap1;
  final Function() onTap2;
  final ProfileTabsEnum activeTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black_s2new_1A1A1A,
        borderRadius: BorderRadius.circular(62),
      ),
      width: width * 2,
      height: 50,
      child: Row(
        children: [
          InkWell(
            onTap: onTap1,
            borderRadius: BorderRadius.circular(62),
            child: Container(
              height: 50,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(62),
                color: enumTap1 == activeTap
                    ? AppColors.primary
                    : AppColors.black_s2new_1A1A1A,
              ),
              child: Center(
                child: Text(
                  text1,
                  textAlign: TextAlign.center,
                  style: AppFonts.font20w600WithColor(enumTap1 == activeTap
                      ? AppColors.black_222232
                      : AppColors.grey_B4B4B4),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onTap2,
            borderRadius: BorderRadius.circular(62),
            child: Container(
              height: 50,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(62),
                color: enumTap2 == activeTap
                    ? AppColors.primary
                    : AppColors.black_s2new_1A1A1A,
              ),
              child: Center(
                child: Text(
                  text2,
                  textAlign: TextAlign.center,
                  style: AppFonts.font20w600WithColor(enumTap2 == activeTap
                      ? AppColors.black_222232
                      : AppColors.grey_B4B4B4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}