import 'package:bcsports_mobile/utils/colors.dart';
import 'package:flutter/material.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.black_222232,
      radius: 23,
      child: InkWell(
        onTap: onTap,
        child: Icon(
          Icons.arrow_back,
          color: AppColors.white,
        ),
      ),
    );
  }
}
