import 'package:bcsports_mobile/features/onboarding/ui/widgets/button_skip.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

class OnboardingThirdWidget extends StatelessWidget {
  const OnboardingThirdWidget({
    super.key,
  });

  static const String mainTitle = "The most trusted way";
  static const String skip = "Skip";
  static const String description =
      "Fincher is best and most popular website for selling and your arts and collections in a very easy and hustle free  process.";
  static const String exploreMore = 'Get Started';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black_101119,
      child: Stack(
        children: [
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
          Positioned(
              right: 0,
              left: 0,
              bottom: -100,
              child: Image.asset(
                "assets/images/onboarding/onboarding3.png",
                width: double.infinity,
                fit: BoxFit.fitWidth,
              )),
          const ButtonSkip()
        ],
      ),
    );
  }
}
