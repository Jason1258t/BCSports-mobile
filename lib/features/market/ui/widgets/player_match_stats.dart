import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

class PlayerMatchStatsWidget extends StatelessWidget {
  // final String value;
  final String attr;

  const PlayerMatchStatsWidget({
    super.key,
    // required this.value,
    required this.attr,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      height: 68,
      width: (size.width - 44 - 8) / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.black_262627,
          border: Border.all(width: 1, color: AppColors.grey_393939)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "TBA",
            style: AppFonts.font16w500.copyWith(color: AppColors.white),
          ),
          Text(
            attr,
            style: AppFonts.font12w300.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
