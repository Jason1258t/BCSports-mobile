import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:flutter/material.dart';

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
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: sizeOf.width * 0.20,
                    ),
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
