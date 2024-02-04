import 'package:bcsports_mobile/features/main/ui/main_screen.dart';
import 'package:bcsports_mobile/features/market/ui/market_screen.dart';
import 'package:bcsports_mobile/features/onboarding/ui/onboarding_screen.dart';
import 'package:bcsports_mobile/features/profile/ui/profile.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static List<Widget> mainPages = [
    MarketScreen(),
    Container(),
    Container(),
    ProfileScreen()
  ];

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final pageArgs = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (ctx) => const MainScreen());
      case '/onboarding':
        return MaterialPageRoute(builder: (ctx) => const OnboardingScreen());
      default:
        return MaterialPageRoute(
            builder: (ctx) => Container(
                  color: Colors.red,
                ));
    }
  }
}
