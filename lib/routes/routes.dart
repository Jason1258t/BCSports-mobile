import 'package:bcsports_mobile/app.dart';
import 'package:bcsports_mobile/features/ar/ui/ar_screen.dart';
import 'package:bcsports_mobile/features/auth/ui/login_screen.dart';
import 'package:bcsports_mobile/features/auth/ui/registration_screen.dart';
import 'package:bcsports_mobile/features/chat/ui/pages/chat_contacts_screen.dart';
import 'package:bcsports_mobile/features/chat/ui/pages/chat_messages_screen.dart';
import 'package:bcsports_mobile/features/market/ui/market_favourites_screen.dart';
import 'package:bcsports_mobile/features/market/ui/market_product_screen.dart';
import 'package:bcsports_mobile/features/market/ui/market_screen.dart';
import 'package:bcsports_mobile/features/onboarding/ui/onboarding_screen.dart';
import 'package:bcsports_mobile/features/profile/ui/profile_edit_screen.dart';
import 'package:bcsports_mobile/features/profile/ui/profile_screen.dart';
import 'package:bcsports_mobile/features/profile/ui/profile_settings_screen.dart';
import 'package:bcsports_mobile/features/profile/ui/profile_view_screen.dart';
import 'package:bcsports_mobile/features/social/ui/create_post_screen.dart';
import 'package:bcsports_mobile/features/social/ui/favourites_screen.dart';
import 'package:bcsports_mobile/features/social/ui/feed_screen.dart';
import 'package:bcsports_mobile/features/wallet/ui/wallet_screen.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:flutter/material.dart';

import '../features/auth/ui/recovery_enter_email_screen.dart';

class AppRoutes {
  static List<Widget> mainPages = [
    const MarketScreen(),
    const ArScreen(),
    const FeedScreen(),
    const ProfileScreen()
  ];

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.root:
        return MaterialPageRoute(builder: (ctx) => const AppStateWidget());
      // return MaterialPageRoute(builder: (ctx) => const AppStateWidget());
      case AppRouteNames.profileSettings:
        return MaterialPageRoute(
            builder: (ctx) => const ProfileSettingScreen());
      case AppRouteNames.createPost:
        return MaterialPageRoute(builder: (ctx) => const CreatePostScreen());
      case AppRouteNames.onboarding:
        return MaterialPageRoute(builder: (ctx) => const OnboardingScreen());
      // return MaterialPageRoute(builder: (ctx) => RegistrationScreen());
      case AppRouteNames.market:
        return MaterialPageRoute(builder: (ctx) => const MarketScreen());
      case AppRouteNames.marketDetails:
        final Map<dynamic, dynamic> pageArgs = settings.arguments as Map;
        final NftModel playerNft = pageArgs['nft'];
        final ProductTarget target = pageArgs['target'];
        return MaterialPageRoute(
            builder: (ctx) => MarketProductScreen(
                  nft: playerNft,
                  target: target,
                ));
      case AppRouteNames.favourites:
        return MaterialPageRoute(
            builder: (ctx) => const MarketFavouritesScreen());
      case AppRouteNames.login:
        return MaterialPageRoute(builder: (ctx) => const LoginScreen());
      case AppRouteNames.registration:
        return MaterialPageRoute(builder: (ctx) => const RegistrationScreen());
      case AppRouteNames.wallet:
        return MaterialPageRoute(builder: (ctx) => const WalletScreen());
      case AppRouteNames.recovery:
        return MaterialPageRoute(
            builder: (ctx) => const PasswordRecoveryScreen());
      case AppRouteNames.profileEdit:
        return MaterialPageRoute(builder: (ctx) => const EditProfileScreen());
      case AppRouteNames.profileView:
        return MaterialPageRoute(builder: (ctx) => const ProfileViewScreen());
      case AppRouteNames.favouritesPost:
        return MaterialPageRoute(builder: (ctx) => const FavouritesScreen());

      case AppRouteNames.chatContacts:
        return MaterialPageRoute(builder: (ctx) => const ChatContactsScreen());
      // case AppRouteNames.chatMessages:
      //   return MaterialPageRoute(builder: (ctx) => const ChatMessagesScreen());

      default:
        return MaterialPageRoute(
            builder: (ctx) => Container(
                  color: Colors.red,
                ));
    }
  }
}
