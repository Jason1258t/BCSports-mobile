import 'package:bcsports_mobile/utils/assets.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          Assets.images('logo.png'),
          width: MediaQuery.sizeOf(context).width * 255 / 375,
        ),
      ],
    );
  }
}
