import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.isActive,
      this.color,
      this.height,
      this.width});

  final String text;
  final VoidCallback onTap;
  final bool isActive;
  final double? width;
  final Color? color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        
        onPressed: isActive ? onTap : () {},
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor:
                isActive ? color ?? AppColors.primary : AppColors.black_s2new_1A1A1A,
            foregroundColor:
                isActive ? AppColors.primary : AppColors.black_s2new_1A1A1A),
        child: Container(
          height: height ?? 67,
          width: width ?? double.infinity,
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppFonts.font18w500
                .copyWith(color: isActive ? Colors.black : Colors.white),
          ),
        ));
  }
}
