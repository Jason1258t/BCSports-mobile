import 'package:bcsports_mobile/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/assets.dart';
import '../../../../utils/fonts.dart';

class MediumActivityWidget extends StatelessWidget {
  const MediumActivityWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.assetIcon,
      required this.title,
      required this.text,
      this.onTap});

  final double width;
  final double height;
  final String assetIcon;
  final String title;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(width * 0.096),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Color(0xFF474322), Color(0xFF201F15)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              Assets.icons(assetIcon),
              color: AppColors.primary,
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppFonts.font18w400.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 10,),
                Text(
                  text,
                  style: AppFonts.font14w300
                      .copyWith(color: AppColors.grey_B3B3B3),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
