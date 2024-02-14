import 'package:bcsports_mobile/app.dart';
import 'package:bcsports_mobile/features/ar/ui/ar_screen.dart';
import 'package:bcsports_mobile/features/auth/ui/login_screen.dart';
import 'package:bcsports_mobile/features/auth/ui/registration_screen.dart';
import 'package:bcsports_mobile/features/chat/ui/pages/chat_contacts_screen.dart';
import 'package:bcsports_mobile/features/market/ui/market_favourites_screen.dart';
import 'package:bcsports_mobile/features/market/ui/market_lots_screen.dart';
import 'package:bcsports_mobile/features/market/ui/market_product_screen.dart';
import 'package:bcsports_mobile/features/market/ui/market_product_sell_screen.dart';
import 'package:bcsports_mobile/features/market/ui/market_screen.dart';
import 'package:bcsports_mobile/features/onboarding/ui/onboarding_screen.dart';
import 'package:bcsports_mobile/features/profile/ui/profile_edit_screen.dart';
import 'package:bcsports_mobile/features/profile/ui/profile_language_screen.dart';
import 'package:bcsports_mobile/features/profile/ui/profile_screen.dart';
import 'package:bcsports_mobile/features/profile/ui/profile_settings_screen.dart';
import 'package:bcsports_mobile/features/profile/ui/profile_view_screen.dart';
import 'package:bcsports_mobile/features/social/ui/create_post_screen.dart';
import 'package:bcsports_mobile/features/social/ui/favourites_screen.dart';
import 'package:bcsports_mobile/features/social/ui/feed_screen.dart';
import 'package:bcsports_mobile/features/wallet/ui/wallet_screen.dart';
import 'package:bcsports_mobile/models/market/market_item_model.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
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
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => const AppStateWidget());
      // return NoAnimationMaterialPageRoute(builder: (ctx) => const AppStateWidget());
      case AppRouteNames.profileSettings:
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => const ProfileSettingScreen());
      case AppRouteNames.createPost:
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => const CreatePostScreen());
      case AppRouteNames.onboarding:
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => const OnboardingScreen());
      // return NoAnimationMaterialPageRoute(builder: (ctx) => RegistrationScreen());
      case AppRouteNames.market:
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => const MarketScreen());
      case AppRouteNames.marketBuy:
        final Map<dynamic, dynamic> pageArgs = settings.arguments as Map;
        final MarketItemModel product = pageArgs['nft'];
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => MarketProductBuyScreen(
                  product: product,
                ));
      case AppRouteNames.marketSell:
        final Map<dynamic, dynamic> pageArgs = settings.arguments as Map;
        final NftModel playerNft = pageArgs['nft'];
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => MarketProductSellScreen(
                  nft: playerNft,
                ));
      case AppRouteNames.favourites:
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => const MarketFavouritesScreen());
      case AppRouteNames.marketLots:
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => const MarketLotsScreen());
      case AppRouteNames.login:
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => const LoginScreen());
      case AppRouteNames.registration:
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => const RegistrationScreen());
      case AppRouteNames.wallet:
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => const WalletScreen());
      case AppRouteNames.recovery:
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => const PasswordRecoveryScreen());
      case AppRouteNames.profileEdit:
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => const EditProfileScreen());
      case AppRouteNames.profileView:
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => const ProfileViewScreen());
      case AppRouteNames.favouritesPost:
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => const FavouritesScreen());
      case AppRouteNames.profileLanguage:
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => const ProfileLanguageScreen());
      case AppRouteNames.chatContacts:
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => const ChatContactsScreen());
      // case AppRouteNames.chatMessages:
      //   return NoAnimationMaterialPageRoute(builder: (ctx) => const ChatMessagesScreen());

      default:
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => Container(
                  color: Colors.red,
                ));
    }
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            builder: builder,
            maintainState: maintainState,
            settings: settings,
            fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
