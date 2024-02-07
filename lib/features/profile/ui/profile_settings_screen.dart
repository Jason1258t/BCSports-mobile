import 'package:bcsports_mobile/features/auth/bloc/auth/auth_cubit.dart';
import 'package:bcsports_mobile/features/auth/bloc/reset_password/reset_password_cubit.dart';
import 'package:bcsports_mobile/features/profile/bloc/edit_user/edit_user_cubit.dart';
import 'package:bcsports_mobile/features/profile/bloc/user/user_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/profile/ui/profile_edit_screen.dart';
import 'package:bcsports_mobile/features/profile/ui/widgets/settings_button.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
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

    return CustomScaffold(
      color: AppColors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
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
      padding: EdgeInsets.symmetric(horizontal: sizeOf.width * 0.05),
      body: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        if (state is UserSuccessState) {
          var user = RepositoryProvider.of<ProfileRepository>(context).user;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: user.avatarColor,
                radius: sizeOf.width * 0.20,
                backgroundImage: NetworkImage(user.avatarUrl ?? ''),
                child: user.avatarUrl == null
                    ? Center(
                        child: Text(
                          (user.displayName ?? user.username)[0].toUpperCase(),
                          style: AppFonts.font64w400,
                        ),
                      )
                    : Container(),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                user.displayName ?? user.username,
                style: AppFonts.font20w600,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                user.displayName == null ? '' : user.username,
                style: AppFonts.font13w100,
              ),
              const SizedBox(
                height: 40,
              ),
              SettingButton(
                  onTap: () {
                    Navigator.pushNamed(context, AppRouteNames.profileEdit);
                  },
                  name: 'Edit profile',
                  width: double.infinity,
                  height: sizeOf.width * 0.16),
              const SizedBox(
                height: 20,
              ),
              SettingButton(
                  onTap: () {
                    // BlocProvider.of<ResetPasswordCubit>(context).resetPassword(user.);
                  },
                  name: 'Change Password',
                  width: double.infinity,
                  height: sizeOf.width * 0.16),
              const SizedBox(
                height: 20,
              ),
              SettingButton(
                  onTap: () {},
                  name: 'Favourites',
                  width: double.infinity,
                  height: sizeOf.width * 0.16),
              const SizedBox(
                height: 20,
              ),
              SettingButton(
                  onTap: () {},
                  name: 'Help',
                  width: double.infinity,
                  height: sizeOf.width * 0.16),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  context.read<AuthCubit>().signOut();
                  Navigator.pop(context);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
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
          );
        } else {
          return Center(
            child: AppAnimations.circleIndicator,
          );
        }
      }),
    );
  }
}
