import 'package:bcsports_mobile/features/onboarding/bloc/cubit/onboarding_cubit.dart';
import 'package:bcsports_mobile/features/onboarding/ui/widgets/button_skip.dart';
import 'package:bcsports_mobile/features/onboarding/ui/widgets/onboarding_first.dart';
import 'package:bcsports_mobile/features/onboarding/ui/widgets/onboarding_fourth.dart';
import 'package:bcsports_mobile/features/onboarding/ui/widgets/onboarding_second.dart';
import 'package:bcsports_mobile/features/onboarding/ui/widgets/onboarding_third.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
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
  final PageController _pageController = PageController();
  int currentPage = 0;

  List<Widget> pages = const [
    OnboardingFirstWidget(),
    OnboardingSecondWidget(),
    OnboardingThirdWidget(),
    OnboardingFourthWidget()
  ];

  void animateToPage() {
    _pageController.animateToPage(currentPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastEaseInToSlowEaseOut);
  }

  void nextPage() {
    if (currentPage == 3) {
      Navigator.pop(context);
    } else {
      setState(() {
        currentPage++;
      });
      animateToPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

    Map<int, String> exploreMoreData = {
      0: localize.explore_more,
      1: localize.next,
      2: localize.next,
      3: localize.start
    };

    return Scaffold(
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
              child: PageView(
                controller: _pageController,
                // physics: CustomScrollPhysics(),
                onPageChanged: (page) {
                  if (page < currentPage) {
                    _pageController.animateToPage(currentPage,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.ease);
                  } else {
                    setState(() {
                      currentPage = page;
                    });
                  }
                },
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
                                isBig: e == currentPage,
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
                  text: exploreMoreData[currentPage] ?? localize.next,
                  onTap: nextPage,
                  isActive: true),
            )
          ],
        ),
      ),
    );
  }
}

// class CustomScrollPhysics extends PageScrollPhysics {
//   CustomScrollPhysics({super.parent});
//
// //   bool isGoingLeft = false;
// //
// //   @override
// //   ScrollPhysics applyTo(ScrollPhysics? ancestor) {
// //     return CustomScrollPhysics(parent: buildParent(ancestor));
// //   }
// //
// //   @override
// //   double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
// //     isGoingLeft = offset.sign < 0;
// //     return offset;
// //   }
// //
// //   @override
// //   double applyBoundaryConditions(ScrollMetrics position, double value) {
// // //print("applyBoundaryConditions");
// //     assert(() {
// //       if (value == position.pixels) {
// //         throw FlutterError(
// //             '$runtimeType.applyBoundaryConditions() was called redundantly.\n'
// //             'The proposed new position, $value, is exactly equal to the current position of the '
// //             'given ${position.runtimeType}, ${position.pixels}.\n'
// //             'The applyBoundaryConditions method should only be called when the value is '
// //             'going to actually change the pixels, otherwise it is redundant.\n'
// //             'The physics object in question was:\n'
// //             '  $this\n'
// //             'The position object in question was:\n'
// //             '  $position\n');
// //       }
// //       return true;
// //     }());
// //     if (value < position.pixels &&
// //         position.pixels <= position.minScrollExtent) {
// //       return value - position.pixels;
// //     }
// //     if (position.maxScrollExtent <= position.pixels &&
// //         position.pixels < value) {
// //       // overscroll
// //       return value - position.pixels;
// //     }
// //     if (value < position.minScrollExtent &&
// //         position.minScrollExtent < position.pixels) {
// //       // hit top edge
// //
// //       return value - position.minScrollExtent;
// //     }
// //
// //     if (position.pixels < position.maxScrollExtent &&
// //         position.maxScrollExtent < value) {
// //       // hit bottom edge
// //       return value - position.maxScrollExtent;
// //     }
// //
// //     if (!isGoingLeft) {
// //       return value - position.pixels;
// //     }
// //     return 0.0;
// //   }
//
//   @override
//   PageScrollPhysics applyTo(ScrollPhysics? ancestor) {
//     return CustomScrollPhysics(parent: buildParent(ancestor));
//   }
//
//   @override
//   double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
//     print(position.axis);
//     print(position.extentAfter);
//     print(position.extentBefore);
//     if (position.axisDirection == AxisDirection.right) {
//       // Если пользователь прокручивает вправо, применяем стандартную физику
//       return super.applyPhysicsToUserOffset(position, offset);
//     } else {
//       // Иначе, игнорируем прокрутку влево
//       return 0.0;
//     }
//   }
// }

class OnboardingDot extends StatelessWidget {
  final bool isBig;

  const OnboardingDot({super.key, this.isBig = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isBig ? 20 : 5,
      height: 5,
      decoration: BoxDecoration(
          color: isBig ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(100)),
      duration: const Duration(milliseconds: 100),
    );
  }
}
