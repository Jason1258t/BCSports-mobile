import 'package:bcsports_mobile/app.dart';
import 'package:bcsports_mobile/features/auth/bloc/app/app_cubit.dart';
import 'package:bcsports_mobile/features/auth/bloc/auth/auth_cubit.dart';
import 'package:bcsports_mobile/features/auth/bloc/reset_password/reset_password_cubit.dart';
import 'package:bcsports_mobile/features/auth/data/auth_repository.dart';
import 'package:bcsports_mobile/features/chat/bloc/user_search_cubit.dart';
import 'package:bcsports_mobile/features/chat/data/chat_repository.dart';
import 'package:bcsports_mobile/features/main/bloc/cubit/main_cubit.dart';
import 'package:bcsports_mobile/features/market/bloc/buy/buy_cubit.dart';
import 'package:bcsports_mobile/features/market/bloc/cansel_lot/cansel_lot_cubit.dart';
import 'package:bcsports_mobile/features/market/bloc/favourite/favourite_cubit.dart';
import 'package:bcsports_mobile/features/market/bloc/lots/lots_cubit.dart';
import 'package:bcsports_mobile/features/market/bloc/nft_details/nft_details_cubit.dart';
import 'package:bcsports_mobile/features/market/bloc/sell/sell_cubit.dart';
import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/features/market/data/nft_service.dart';
import 'package:bcsports_mobile/features/onboarding/bloc/cubit/onboarding_cubit.dart';
import 'package:bcsports_mobile/features/profile/bloc/profile_view/profile_view_cubit.dart';
import 'package:bcsports_mobile/features/profile/bloc/user/user_cubit.dart';
import 'package:bcsports_mobile/features/profile/bloc/user_nft/user_nft_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/profile/data/profile_view_repository.dart';
import 'package:bcsports_mobile/features/social/bloc/create_post/create_post_cubit.dart';
import 'package:bcsports_mobile/features/social/bloc/delete_post/delete_post_cubit.dart';
import 'package:bcsports_mobile/features/social/bloc/like/like_cubit.dart';
import 'package:bcsports_mobile/features/social/bloc/post_comments/post_comments_cubit.dart';
import 'package:bcsports_mobile/features/social/data/favourite_posts_repository.dart';
import 'package:bcsports_mobile/features/social/data/likes_manager.dart';
import 'package:bcsports_mobile/features/social/data/social_repository.dart';
import 'package:bcsports_mobile/services/locale/localization/localization_cubit.dart';
import 'package:bcsports_mobile/services/locale/localization/localization_service.dart';
import 'package:bcsports_mobile/services/locale/preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/social/bloc/home/home_social_cubit.dart';

import 'features/profile/bloc/edit_user/edit_user_cubit.dart';

PreferencesService preferencesService = PreferencesService();

class MyRepositoryProviders extends StatelessWidget {
  const MyRepositoryProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final likes = LikesManager();
    final nftService = NftService();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ChatRepository()),
        RepositoryProvider(
            create: (context) => ProfileRepository(likes, nftService)),
        RepositoryProvider(create: (context) => SocialRepository(likes)),
        RepositoryProvider(
            create: (context) => FavouritePostsRepository(likes)),
        RepositoryProvider(
            create: (context) => MarketRepository(
                nftService: nftService,
                profileRepository: context.read<ProfileRepository>())),
        RepositoryProvider(
            create: (context) => ProfileViewRepository(
                likes, nftService, context.read<MarketRepository>())),
        RepositoryProvider(
          create: (context) => AuthRepository(),
          lazy: false,
        )
      ],
      child: const MyBlocProviders(),
    );
  }
}

class MyBlocProviders extends StatelessWidget {
  const MyBlocProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocalizationService localizationService = LocalizationService(preferencesService);
    

    final authRepository = RepositoryProvider.of<AuthRepository>(context);
    final marketRepository = RepositoryProvider.of<MarketRepository>(context);
    final profileRepository = RepositoryProvider.of<ProfileRepository>(context);
    final profileViewRepository =
        RepositoryProvider.of<ProfileViewRepository>(context);
    final socialRepository = RepositoryProvider.of<SocialRepository>(context);
    final favouritesRepository =
        RepositoryProvider.of<FavouritePostsRepository>(context);
    final chatRepository = RepositoryProvider.of<ChatRepository>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnboardingCubit()),
        BlocProvider(
          create: (context) => AuthCubit(authRepository),
          lazy: false,
        ),
        BlocProvider(
            create: (context) => AppCubit(authRepository, profileRepository,
                socialRepository, favouritesRepository, marketRepository),
            lazy: false),
        BlocProvider(create: (context) => ResetPasswordCubit(authRepository)),
        BlocProvider(
            create: (context) =>
                EditUserCubit(profileRepository: profileRepository)),
        BlocProvider(
            create: (context) =>
                UserCubit(profileRepository: profileRepository)),
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(
            create: (context) =>
                BuyNftCubit(profileRepository, marketRepository)),
        BlocProvider(create: (context) => FavouriteCubit(profileRepository)),
        BlocProvider(
            create: (context) =>
                CreatePostCubit(socialRepository, profileRepository)),
        BlocProvider(
            create: (context) =>
                HomeSocialCubit(socialRepository, profileRepository)),
        BlocProvider(create: (context) => NftDetailsCubit(marketRepository)),
        BlocProvider(create: (context) => UserNftCubit(profileRepository)),
        BlocProvider(
            create: (context) =>
                LikeCubit(profileRepository, favouritesRepository)),
        BlocProvider(
            create: (context) =>
                PostCommentsCubit(socialRepository, profileRepository)),
        BlocProvider(
            create: (context) =>
                ProfileViewCubit(profileRepository: profileViewRepository)),
        BlocProvider(
            create: (context) =>
                UserSearchCubit(chatRepository: chatRepository)),
        BlocProvider(create: (context) => SellCubit(profileRepository)),
        BlocProvider(create: (context) => LotsCubit(marketRepository)),
        BlocProvider(
            create: (context) =>
                CanselLotCubit(marketRepository, profileRepository)),
        BlocProvider(create: (context) => LocalizationCubit(localizationService), lazy: false,),
        BlocProvider(create: (context) => DeletePostCubit(profileRepository)),
      ],
      child: const MyApp(),
    );
  }
}
