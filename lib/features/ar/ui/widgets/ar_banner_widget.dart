import 'package:bcsports_mobile/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/assets.dart';
import '../../../../utils/fonts.dart';

class ArBannerWidget extends StatelessWidget {
  const ArBannerWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.assetIcon,
      required this.title,
      required this.text,
      required this.backGroundImage});

  final double width;
  final double height;
  final String assetIcon;
  final String title;
  final String text;
  final String backGroundImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(width * 0.036),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(Assets.images(backGroundImage)),
            fit: BoxFit.cover
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            Assets.icons(assetIcon),
            color: AppColors.primary,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppFonts.font18w400.copyWith(color: AppColors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                text,
                style:
                    AppFonts.font12w300.copyWith(color: AppColors.grey_727477),
              ),
            ],
          )
        ],
      ),
    );
  }
}
