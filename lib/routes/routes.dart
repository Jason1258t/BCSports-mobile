import 'package:bcsports_mobile/app.dart';
import 'package:bcsports_mobile/routes/routes_names.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  RouteNames.root: (context) => const MyApp(),
};
