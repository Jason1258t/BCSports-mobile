import 'package:bcsports_mobile/app.dart';
import 'package:bcsports_mobile/features/auth/bloc/app/app_cubit.dart';
import 'package:bcsports_mobile/features/auth/bloc/auth/auth_cubit.dart';
import 'package:bcsports_mobile/features/auth/data/auth_repository.dart';
import 'package:bcsports_mobile/features/main/bloc/cubit/main_cubit.dart';
import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/features/onboarding/bloc/cubit/onboarding_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyRepositoryProviders extends StatelessWidget {
  const MyRepositoryProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => MarketRepository()),
        RepositoryProvider(create: (context) => ProfileRepository()),
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

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnboardingCubit()),
        BlocProvider(create: (context) => AuthCubit(authRepository)),
        BlocProvider(create: (context) => AppCubit(authRepository)),
        BlocProvider(create: (context) => MainCubit()),
      ],
      child: const MyApp(),
    );
  }
}
