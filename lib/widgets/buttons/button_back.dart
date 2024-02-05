import 'package:bcsports_mobile/utils/colors.dart';
import 'package:flutter/material.dart';

class ButtonBack extends StatelessWidget {
  final bool isDark;

  const ButtonBack({super.key, required this.onTap, this.isDark = true});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: isDark ? AppColors.black_222232 : AppColors.white,
      radius: 20,
      child: InkWell(
        onTap: onTap,
        child: Icon(
          Icons.arrow_back,
          color: isDark ? AppColors.white : AppColors.black_252525,
        ),
      ),
    );
  }
}
