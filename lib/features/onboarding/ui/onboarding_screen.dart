import 'package:bcsports_mobile/features/onboarding/bloc/cubit/onboarding_cubit.dart';
import 'package:bcsports_mobile/features/onboarding/ui/widgets/onboarding_first.dart';
import 'package:bcsports_mobile/features/onboarding/ui/widgets/onboarding_second.dart';
import 'package:bcsports_mobile/features/onboarding/ui/widgets/onboarding_third.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  Map<int, String> exploreMoreData = {
    0: "Explore more",
    1: "Next",
    2: "Get Started"
  };
  final PageController _pageController = PageController();

  late OnboardingCubit bloc;

  List<Widget> pages = [
    OnboardingFirstWidget(),
    OnboardingSecondWidget(),
    OnboardingThirdWidget()
  ];

  @override
  void initState() {
    bloc = context.read<OnboardingCubit>();
    super.initState();
  }

  void animateToPage() {
    _pageController.animateToPage(bloc.currentPageIndex,
        duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
  }

  void nextPage() {
    bloc.nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        animateToPage();
      },
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
                child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: pages,
            )),
            InkWell(
              onTap: () => nextPage(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                width: double.infinity,
                height: 83,
                color: AppColors.yellow_F3D523,
                child: Row(
                  children: [
                    Container(
                      width: 37,
                      height: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OnboardingDot(),
                          OnboardingDot(isBig: true,),
                          OnboardingDot(),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      exploreMoreData[bloc.currentPageIndex] ?? "Next",
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
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OnboardingDot extends StatelessWidget {
  final bool isBig;

  const OnboardingDot({
    super.key,
    this.isBig = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: isBig ? 20 : 5,
        height: 5,
        decoration: BoxDecoration(
            color: AppColors.black_090723,
            borderRadius: BorderRadius.circular(100)));
  }
}
