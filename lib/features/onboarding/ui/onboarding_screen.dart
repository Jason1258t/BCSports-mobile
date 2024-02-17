import 'package:bcsports_mobile/features/onboarding/bloc/cubit/onboarding_cubit.dart';
import 'package:bcsports_mobile/features/onboarding/ui/widgets/button_skip.dart';
import 'package:bcsports_mobile/features/onboarding/ui/widgets/onboarding_first.dart';
import 'package:bcsports_mobile/features/onboarding/ui/widgets/onboarding_fourth.dart';
import 'package:bcsports_mobile/features/onboarding/ui/widgets/onboarding_second.dart';
import 'package:bcsports_mobile/features/onboarding/ui/widgets/onboarding_third.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  Map<int, String> exploreMoreData = {
    0: "Explore more",
    1: "Next",
    2: "Next",
    3: "Start"
  };
  final PageController _pageController = PageController();

  late OnboardingCubit bloc;

  List<Widget> pages = const [
    OnboardingFirstWidget(),
    OnboardingSecondWidget(),
    OnboardingThirdWidget(),
    OnboardingFourthWidget()
  ];

  @override
  void initState() {
    bloc = BlocProvider.of<OnboardingCubit>(context);
    super.initState();
  }

  void animateToPage() {
    _pageController.animateToPage(bloc.currentPageIndex,
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastEaseInToSlowEaseOut);
  }

  void nextPage() {
    if (bloc.currentPageIndex == bloc.maxPageIndex) {
      Navigator.pop(context);
    } else {
      bloc.nextPage();
    }
  }

  @override
  void dispose() {
    bloc.resetStartPageIndex();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        animateToPage();
      },
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    "assets/images/onboarding/onboarding_bg.png",
                  ))),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                left: 0,
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: pages,
                ),
              ),
              Positioned(
                top: 70,
                left: 27,
                right: 27,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 47,
                      height: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: exploreMoreData.keys
                            .map((e) => OnboardingDot(
                                  isBig: e == bloc.currentPageIndex,
                                ))
                            .toList(),
                      ),
                    ),
                    const ButtonSkip()
                  ],
                ),
              ),
              Positioned(
                bottom: 32,
                right: 23,
                left: 23,
                child: CustomTextButton(
                    text: exploreMoreData[bloc.currentPageIndex] ?? "Next",
                    onTap: nextPage,
                    isActive: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class OnboardingDot extends StatelessWidget {
  final bool isBig;

  const OnboardingDot({super.key, this.isBig = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: isBig ? 20 : 5,
        height: 5,
        decoration: BoxDecoration(
            color: isBig ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(100)));
  }
}
