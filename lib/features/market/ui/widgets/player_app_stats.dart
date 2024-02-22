import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayerAppStatsWidget extends StatelessWidget {
  final String iconPath;
  final String statsName;
  final String value;

  const PlayerAppStatsWidget({
    super.key,
    required this.iconPath,
    required this.statsName,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      padding: const EdgeInsets.all(2),
      width: size.width * 0.43,
      height: 56,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.black_262627,
          border: Border.all(width: 1, color: AppColors.black_3A3A3A)),
      child: Stack(
        children: [
          Positioned(
              top: 8,
              right: 8,
              child: SvgPicture.asset(
                iconPath,
                color: AppColors.brown_6C6226,
              )),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: AppFonts.font16w500.copyWith(color: AppColors.white),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  statsName.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: AppFonts.font12w400.copyWith(color: AppColors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
