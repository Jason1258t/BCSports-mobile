import 'package:bcsports_mobile/features/profile/ui/profile.dart';
import 'package:bcsports_mobile/routes/routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BCSports',
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
