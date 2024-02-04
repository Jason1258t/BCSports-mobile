import 'package:bcsports_mobile/features/auth/bloc/app/app_cubit.dart';
import 'package:bcsports_mobile/features/auth/ui/login_screen.dart';
import 'package:bcsports_mobile/features/profile/ui/profile_screen.dart';
import 'package:bcsports_mobile/features/splash/splash_screen.dart';
import 'package:bcsports_mobile/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BCSports',
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

class AppStateWidget extends StatelessWidget {
  const AppStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      if (state is AppUnAuthState) return const LoginScreen();
      if (state is AppAuthState) return const ProfileScreen();
      if (state is AppInitial) return const SplashScreen();
      return Container();
    });
  }
}
