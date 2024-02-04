import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

class AppSnackBars {
  static SnackBar snackBar(String text) => SnackBar(
        elevation: 0,
        content: Text(
          text,
          style: AppFonts.font14w400,
        ),
        backgroundColor: AppColors.black_s2new_1A1A1A,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      );
}
