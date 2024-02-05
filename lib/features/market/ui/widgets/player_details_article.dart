import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

class PlayerDetailsArticleWidget extends StatelessWidget {
  final String title;

  const PlayerDetailsArticleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: AppFonts.font18w400.copyWith(
          color: AppColors.white,
        ));
  }
}