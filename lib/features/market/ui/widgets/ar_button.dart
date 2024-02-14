import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/utils/gradients.dart';
import 'package:flutter/material.dart';

class NftArButton extends StatelessWidget {
  final bool isActive;
  String arButton = "Go to AR";

  NftArButton({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: isActive ? AppGradients.ar : null,
          color: isActive ? null : AppColors.black_s2new_1A1A1A,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Center(
          child: Text(
            arButton.toUpperCase(),
            style: AppFonts.font36w800ItalicAS
                .copyWith(color: isActive ? AppColors.black_s2new_1A1A1A : AppColors.white),
          ),
        ),
      ),
    );
  }
}
