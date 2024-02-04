import 'package:bcsports_mobile/features/auth/bloc/auth/auth_cubit.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/assets.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Container(
      color: AppColors.black_090723,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Scaffold(
            backgroundColor: AppColors.black_090723,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              flexibleSpace: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ButtonBack(onTap: () {
                    Navigator.pop(context);
                  }),
                  Text(
                    'Settings',
                    style: AppFonts.font18w600,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                ],
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                ),
                CircleAvatar(
                  radius: sizeOf.width * 0.20,
                ),
                const SizedBox(height: 25,),
                Text(
                  'Andrian',
                  style: AppFonts.font20w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '@ideasbyandian',
                  style: AppFonts.font13w100,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthCubit>().signOut();
                    Navigator.pushNamed(context, '');
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.icons('logout.svg')),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5, left: 10),
                        child: Text(
                          'Log out',
                          style: AppFonts.font16w400
                              .copyWith(color: AppColors.yellow_F3D523),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
