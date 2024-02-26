import 'package:bcsports_mobile/utils/colors.dart';
import 'package:flutter/material.dart';

class ButtonBack extends StatelessWidget {
  final bool isDark;

  const ButtonBack({super.key, required this.onTap, this.isDark = true, this.backgroundColor});

  final Function() onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(
          Icons.arrow_back,
          color: isDark ? AppColors.white : AppColors.black_252525,
        ),
      ),
    );
  }
}
