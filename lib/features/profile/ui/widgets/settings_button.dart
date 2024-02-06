import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  const SettingButton(
      {super.key,
      required this.onTap,
      required this.name,
      required this.width,
      required this.height});

  final Function() onTap;
  final String name;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(13),
      onTap: onTap,
      child: Ink(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.black_3A3A3A,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: AppFonts.font14w500,
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
