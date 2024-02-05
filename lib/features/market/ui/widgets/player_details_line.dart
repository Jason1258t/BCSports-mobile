import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';


class PlayerDetailsLineWidget extends StatelessWidget {
  final String attr;
  final String value;

  const PlayerDetailsLineWidget({
    super.key,
    required this.attr,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: AppColors.grey_2F2F2F))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              attr,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.font12w300.copyWith(color: AppColors.grey_B3B3B3),
            ),
          ),
          SizedBox(
            width: size.width * 0.6,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.font14w400.copyWith(color: AppColors.white),
            ),
          )
        ],
      ),
    );
  }
}
