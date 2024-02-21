import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/utils/gradients.dart';
import 'package:flutter/material.dart';

class NftArButton extends StatelessWidget {
  final bool isActive;

  NftArButton({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;
    String arButton = localize.go_ar;

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
            style: AppFonts.font36w800ItalicAS.copyWith(
                color:
                    isActive ? AppColors.black_s2new_1A1A1A : AppColors.white),
          ),
        ),
      ),
    );
  }
}
