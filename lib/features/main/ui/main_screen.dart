import 'package:bcsports_mobile/features/main/bloc/cubit/main_cubit.dart';
import 'package:bcsports_mobile/features/main/ui/widgets/bottom_navigation_bar.dart';
import 'package:bcsports_mobile/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: AppRoutes.mainPages[context.read<MainCubit>().currentPageIndex],
          bottomNavigationBar: CustomButtonNavBar(),
        );
      },
    ));
  }
}
