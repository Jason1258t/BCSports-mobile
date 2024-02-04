import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          Assets.icons('BCS Logo.svg'),
          width: MediaQuery.sizeOf(context).width * 255 / 375,
        ),
        // const SizedBox(
        //   height: 10,
        // ),
        // SizedBox(
        //   width: MediaQuery.of(context).size.width / 2,
        //   child: Text('Welcome to the fincher', style: AppFonts.font24w600, textAlign: TextAlign.center,),
        // )
      ],
    );
  }
}
