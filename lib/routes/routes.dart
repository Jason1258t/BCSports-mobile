import 'package:bcsports_mobile/features/market/ui/market_screen.dart';
import 'package:bcsports_mobile/features/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final pageArgs = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (ctx) => OnboardingScreen());
      case '/market':
        return MaterialPageRoute(builder: (ctx) => MarketScreen());
      default:
        return MaterialPageRoute(
            builder: (ctx) => Container(
                  color: Colors.red,
                ));
    }
  }
}
