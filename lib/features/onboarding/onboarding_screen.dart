import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String mainTitle = "Unlock the future";
  String skip = "Skip";
  String description =
      "Fincher is a over expanding network of many interlinked applications and services for building an ecosystem of decenteralized future.";
  String exploreMore = 'Explore more';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black_101119,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Expanded(
                  child: PageView(
                children: [
                  Container(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    skip,
                                    style: AppFonts.font16w600
                                        .copyWith(color: AppColors.white),
                                  )
                                ],
                              ),
                              Text(
                                mainTitle,
                                style: AppFonts.font44w800,
                              ),
                              Text(
                                description,
                                style: AppFonts.font14w300
                                    .copyWith(color: AppColors.white_F4F4F4),
                              ),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(
                              "assets/images/onboarding/onboarding1.png",
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                            ))
                      ],
                    ),
                  )
                ],
              )),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                width: double.infinity,
                height: 83,
                color: AppColors.yellow_F3D523,
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 10,
                      color: Colors.black,
                    ),
                    const Spacer(),
                    Text(
                      exploreMore,
                      style: AppFonts.font16w500
                          .copyWith(color: AppColors.black_090723),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    SvgPicture.asset(
                      'assets/icons/arrow.svg',
                      width: 40,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
