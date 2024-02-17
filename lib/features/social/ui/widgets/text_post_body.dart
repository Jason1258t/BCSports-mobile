import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

class TextPostBody extends StatelessWidget {
  const TextPostBody({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppFonts.font16w400.copyWith(color: AppColors.white_F4F4F4),
    );
  }
}
