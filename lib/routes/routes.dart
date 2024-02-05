import 'package:bcsports_mobile/app.dart';
import 'package:bcsports_mobile/features/auth/ui/login_screen.dart';
import 'package:bcsports_mobile/features/main/ui/main_screen.dart';
import 'package:bcsports_mobile/features/auth/ui/registration_screen.dart';
import 'package:bcsports_mobile/features/market/ui/market_screen.dart';
import 'package:bcsports_mobile/features/onboarding/ui/onboarding_screen.dart';
import 'package:bcsports_mobile/features/profile/ui/profile_screen.dart';
import 'package:bcsports_mobile/features/profile/ui/profile_settings_screen.dart';
import 'package:flutter/material.dart';

import '../features/auth/ui/recovery_enter_email_screen.dart';

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
        return MaterialPageRoute(builder: (ctx) => const AppStateWidget());
        // return MaterialPageRoute(builder: (ctx) => const AppStateWidget());
      case '/profile_settings':
        return MaterialPageRoute(builder: (ctx) => const ProfileSettingScreen());
      case '/onboarding':
        return MaterialPageRoute(builder: (ctx) => const OnboardingScreen());
        return MaterialPageRoute(builder: (ctx) => RegistrationScreen());
      case '/market':
        return MaterialPageRoute(builder: (ctx) => const MarketScreen());
      case '/login':
        return MaterialPageRoute(builder: (ctx) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (ctx) => const RegistrationScreen());
      case '/recovery':
        return MaterialPageRoute(builder: (ctx) => const PasswordRecoveryScreen());
      default:
        return MaterialPageRoute(
            builder: (ctx) => Container(
                  color: Colors.red,
                ));
    }
  }
}
