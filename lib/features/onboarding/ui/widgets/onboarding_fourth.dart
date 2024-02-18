import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

class OnboardingFourthWidget extends StatelessWidget {
  const OnboardingFourthWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;
    String mainTitle = localize.trust_way; 
    String description = localize.fincher_best;
    return Stack(
      children: [
        Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Image.asset(
              "assets/images/onboarding/onboarding2.png",
              width: double.infinity,
              fit: BoxFit.fitWidth,
            )),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 22).copyWith(top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 36,
              ),
              Text(
                mainTitle,
                style: AppFonts.font44w800.copyWith(height: 1.13),
              ),
              const SizedBox(
                height: 19,
              ),
              Text(
                description,
                style: AppFonts.font14w300
                    .copyWith(color: AppColors.white_F4F4F4, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
