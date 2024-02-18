import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

class OnboardingSecondWidget extends StatelessWidget {
  const OnboardingSecondWidget({
    super.key,
  });

  static const String mainTitle = "Unlock the future"; //TODO
  static const String description =
      "Fincher is a over expanding network of many interlinked applications and services for building an ecosystem of decenteralized future.";


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: Image.asset(
            "assets/images/onboarding/onboarding4.png",
            fit: BoxFit.fitWidth,
            width: double.infinity,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(
                flex: 3,
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
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
