import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/colors.dart';

class WalletAction extends StatelessWidget {
  const WalletAction(
      {super.key,
        required this.title,
        required this.icon,
        required this.onTap,
        this.isActive = true,
        this.iconColor = Colors.black});

  final String title;
  final String icon;
  final Function onTap;
  final bool isActive;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    final double buttonSize =  sizeOf.width * 0.156 < 70 ? sizeOf.width * 0.156 : 70;
    return Column(
      children: [
        Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () => onTap(),
            icon: SvgPicture.asset(
              icon,
              color: iconColor,
              width: buttonSize * 0.067 / 0.156,
              height: buttonSize * 0.067 / 0.156,
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          title,
          style: AppFonts.font12w400,
        ),
      ],
    );
  }
}
