import 'package:bcsports_mobile/app.dart';
import 'package:bcsports_mobile/features/auth/bloc/app/app_cubit.dart';
import 'package:bcsports_mobile/features/auth/bloc/auth/auth_cubit.dart';
import 'package:bcsports_mobile/features/auth/bloc/reset_password/reset_password_cubit.dart';
import 'package:bcsports_mobile/features/auth/data/auth_repository.dart';
import 'package:bcsports_mobile/features/main/bloc/cubit/main_cubit.dart';
import 'package:bcsports_mobile/features/market/bloc/cubit/market_cubit.dart';
import 'package:bcsports_mobile/features/market/bloc/place_bid/place_bid_cubit.dart';
import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/features/onboarding/bloc/cubit/onboarding_cubit.dart';
import 'package:bcsports_mobile/features/profile/bloc/user/user_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/social/bloc/create_post/create_post_cubit.dart';
import 'package:bcsports_mobile/features/social/data/social_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/profile/bloc/edit_user/edit_user_cubit.dart';

class MyRepositoryProviders extends StatelessWidget {
  const MyRepositoryProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => MarketRepository()),
        RepositoryProvider(create: (context) => ProfileRepository()),
        RepositoryProvider(create: (context) => SocialRepository()),
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
    final authRepository = RepositoryProvider.of<AuthRepository>(context);
    final marketRepository = RepositoryProvider.of<MarketRepository>(context);
    final profileRepository = RepositoryProvider.of<ProfileRepository>(context);
    final socialRepository = RepositoryProvider.of<SocialRepository>(context);
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnboardingCubit()),
        BlocProvider(
          create: (context) => AuthCubit(authRepository),
          lazy: false,
        ),
        BlocProvider(
            create: (context) => AppCubit(authRepository, profileRepository),
            lazy: false),
        BlocProvider(create: (context) => ResetPasswordCubit(authRepository)),
        BlocProvider(create: (context) => MarketCubit(marketRepository)),
        BlocProvider(
            create: (context) =>
                EditUserCubit(profileRepository: profileRepository)),
        BlocProvider(
            create: (context) =>
                UserCubit(profileRepository: profileRepository)),
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => PlaceBidCubit(marketRepository)),
        BlocProvider(
            create: (context) =>
                CreatePostCubit(socialRepository, profileRepository)),
      ],
      child: const MyApp(),
    );
  }
}
