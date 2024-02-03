import 'package:bcsports_mobile/features/onboarding/ui/widgets/button_skip.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

class OnboardingFirstWidget extends StatelessWidget {
  OnboardingFirstWidget({
    super.key,
  });

  String mainTitle = "Unlock the future";
  String description =
      "Fincher is a over expanding network of many interlinked applications and services for building an ecosystem of decenteralized future.";
  String exploreMore = 'Explore more';

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
                "assets/images/onboarding/onboarding1.png",
                width: double.infinity,
                fit: BoxFit.fitWidth,
              )),
          ButtonSkip()
        ],
      ),
    );
  }
}
